function [MAE_delta,MAE_Hy,MAE_deltaS,MAE_avg1 ,MAE_avg2,RMSE_delta,RMSE_deltaS,RMSE_Hy,RMSE_avg1,RMSE_avg2]= runFile_delta(dataset,rt,weight,k)
%函数功能：预测
%输入：抽取之后的数据集，预测的序列数量，原始的数据集
%输出：MAE，RMSE
%生成之后的矩阵
%实验矩阵preData, 原始矩阵dataset
% preData= generateData(density,dataset);
%随机预测10个序列
num = size(dataset,3);
predictValue = cell(k,1);
predictService = cell(k,1);
predictValue_delta = cell(k,1);
predictService_delta=cell(k,1);
predictService_hy = cell(k,1);
realValue = cell(k,1); 
% accurancy = zeros(k,1);
for i=1:k
    [targetUser,targetService] = findTarget(dataset);
    [userID,serviceID] = getSimilarUserAndService(targetUser,targetService,dataset);
    predictValue{i} = reshape(dataset(userID,targetService,:),[64,1]);   
    predictService{i} = reshape(dataset(targetUser,serviceID,:),[64,1]);   
    deltaP = user_scale_cal(dataset,targetUser,targetService,userID);
    deltaS = service_delta_cal(dataset,targetUser,targetService,serviceID);
    predictValue_delta{i} =  predictValue{i}*deltaP;
    predictService_delta{i} = predictService{i}*deltaS; 
    predictService_hy{i} = predictValue_delta{i}*weight+ predictService_delta{i}*(1-weight);
    realValue{i} = reshape(rt(targetUser,targetService,:),[64,1]);
%     %#################开始画图###################
    %第二种预测方式
    plot([1:64],predictValue_delta{i},'g+');
    hold on
    %用相似用户预测
    plot([1:64],predictService_delta{i},'rx');
    hold on
    %混合预测
    plot([1:64],predictService_hy{i},'ro');
    hold on
    %真实值
    plot([1:64],realValue{i},'b<');
    close;   
end 
%获得所有的预测值
pM1= zeros(num, k);
pM2 = zeros(num, k);
pM3 = zeros(num,k);
%获得所有的真实值
rM = zeros(num,k);
for i =1:k
    pM1(:,i) = predictValue_delta{i};
    pM2(:,i) = predictService_delta{i};
    pM3(:,i) = predictService_hy{i};
    rM(:,i) = realValue{i};
end
%% 以下计算目标服务在所有用户的平均值
userNum = size(dataset,1);
total = 0;
for i =1:userNum 
    total = total + sum(dataset(i,targetService,:));
end
avgService = total/(userNum*num);
%%计算目标用户所在服务的平均值
serviceNum = size(dataset,2);
totalS = 0;
for i =1:serviceNum
    totalS = totalS + sum(dataset(targetUser,i,:));
end
avgUser = totalS/(serviceNum*num);
%%计算误差率
count = num*k;
MAE_delta = sum(abs(pM1(:)- rM(:)))/ count;
MAE_deltaS = sum(abs(pM2(:)- rM(:)))/ count;
MAE_Hy = sum(abs(pM3(:)- rM(:)))/ count; %混合预测
MAE_avg1 = sum(abs(avgService*ones(count,1) - rM(:)))/ count;
MAE_avg2 = sum(abs(avgUser*ones(count,1) - rM(:)))/ count;
RMSE_delta=sqrt(sum((pM1(:)- rM(:)).^2)/count);
RMSE_deltaS=sqrt(sum((pM2(:)- rM(:)).^2)/count);
RMSE_Hy = sqrt(sum((pM3(:)- rM(:)).^2)/count); %混合预测
RMSE_avg1=sqrt(sum((avgService*ones(count,1) - rM(:)).^2)/count);
RMSE_avg2=sqrt(sum((avgUser*ones(count,1) - rM(:)).^2)/count);