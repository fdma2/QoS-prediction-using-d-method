function [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile5(density,dataset,k,top_num)
%函数功能：运行实验
%输入：矩阵密度，数据集,要预测的数量
%输出：MAE，RMSE
%生成之后的矩阵
%实验矩阵preData, 原始矩阵dataset
preData= generateData(density,dataset);
%随机预测10个序列
%num = k*size(dataset,3);                                     %为什么是kX序列长
num = size(dataset,3);
[x,y] = find(preData(:,:,1)==0);
n = numel(x);
%randx = x(ceil(rand(1,k)*n));                            % 2018.01.10 0:41注释： 这里有错误，x是（n,1)的序列，而使用（1,k）的序列来生成新的序列，结果只能得到第一个数值
%  flag判断是否在目标序列中有0数值的序列
zero_flag = 0;                                            
randx = randperm(n,k);
gtime = 0;
while zero_flag == 0                                   %this loop judges if there is 0-arrary in the sequence, if exists, regenerate k random samples.
    zero_flag = 1;
    for i = 1:k
        if sum(abs(dataset(x(randx(i)),y(randx(i))))) ==0
            gtime = gtime + 1;
            randx = randperm(n,k);
            zero_flag = 0;
            break;
        end
    end
end
if gtime > 0
    fprintf('regenerating new k none-zero array,time:%d\n',gtime);    %如果有重新生成序列，显示重新生成的次数
end
%开始预测
predict = [x(randx),y(randx)];
predictValue = cell(k,1);
predictValue_service =cell(k,1);
realValue = cell(k,1);
for i=1:k
    targetUser =  predict(i,1);
    targetService = predict(i,2);
    [userID,serviceID] = getSimilarUserAndService5(targetUser,targetService,preData,density,top_num);
    user_top = zeros(num,top_num);
    service_top = zeros(num,top_num);
    user_total = zeros(num,1);
    service_total = zeros(num,1);
    for j = 1:top_num
        user_top(:,j) = reshape(dataset(userID(j),targetService,:),[num,1]);
        service_top(:,j) = reshape(dataset(targetUser,serviceID(j),:),[num,1]);
        user_total = user_total + (top_num-j+1)*user_top(:,j);
        service_total = service_total + (top_num-j+1)*service_top(j);
    end
    predictValue{i} = user_total/sum(1:top_num);
    predictValue_service{i} = service_total/sum(1:top_num);
    realValue{i} = reshape(dataset(targetUser,targetService,:),[64,1]);     % 这里有错误，这是 1X1X64的矩阵, 已改为reshape
    %#################开始画图###################
    %用相似服务预测
    plot(1:num,predictValue_service{i},'g+');
    hold on
    %用相似用户预测
    plot(1:num,predictValue{i},'rx');
    hold on
    plot(1:num,realValue{i},'b<');
%     hold on 
%     diff = realValue{i};
%         for m=1:64   
%         plot([m,m],[tmp(m,2),diff(m)],'k-');
%     end
    close;   
end 
%获得所有的预测值
uM = zeros(num, k);
%获得所有的预测值
sM = zeros(num, k);
%获得所有的真实值
rM = zeros(num,k);
for i =1:k
    uM(:,i) = predictValue{i};
    rM(:,i) = realValue{i};
    sM(:,i) = predictValue_service{i};
end
%% 以下计算目标服务在所有用户的平均值
userNum = size(dataset,1);
total = 0;
for i =1:userNum 
    total = total + sum(dataset(i,targetService,:));
end
avgService = total/(userNum*num);
%% 计算误差
MAE_user  = sum(abs(uM(:) - rM(:)))/ (num*k);
MAE_service  = sum(abs(sM(:) - rM(:)))/ (num*k);
MAE_avgUser= sum(abs(avgService*ones(num*k,1) - rM(:)))/ (num*k);
RMSE_user=sqrt(sum((uM(:) - rM(:)).^2)/(num*k));
RMSE_service=sqrt(sum((sM(:) - rM(:)).^2)/(num*k));
RMSE_avgUser=sqrt(sum((avgService*ones(num*k,1) - rM(:)).^2)/(num*k));