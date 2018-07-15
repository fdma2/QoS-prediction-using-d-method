function [MAE_delta,MAE_Hy,MAE_deltaS,MAE_avg1 ,MAE_avg2,RMSE_delta,RMSE_deltaS,RMSE_Hy,RMSE_avg1,RMSE_avg2]= runFile_delta(dataset,rt,weight,k)
%�������ܣ�Ԥ��
%���룺��ȡ֮������ݼ���Ԥ�������������ԭʼ�����ݼ�
%�����MAE��RMSE
%����֮��ľ���
%ʵ�����preData, ԭʼ����dataset
% preData= generateData(density,dataset);
%���Ԥ��10������
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
%     %#################��ʼ��ͼ###################
    %�ڶ���Ԥ�ⷽʽ
    plot([1:64],predictValue_delta{i},'g+');
    hold on
    %�������û�Ԥ��
    plot([1:64],predictService_delta{i},'rx');
    hold on
    %���Ԥ��
    plot([1:64],predictService_hy{i},'ro');
    hold on
    %��ʵֵ
    plot([1:64],realValue{i},'b<');
    close;   
end 
%������е�Ԥ��ֵ
pM1= zeros(num, k);
pM2 = zeros(num, k);
pM3 = zeros(num,k);
%������е���ʵֵ
rM = zeros(num,k);
for i =1:k
    pM1(:,i) = predictValue_delta{i};
    pM2(:,i) = predictService_delta{i};
    pM3(:,i) = predictService_hy{i};
    rM(:,i) = realValue{i};
end
%% ���¼���Ŀ������������û���ƽ��ֵ
userNum = size(dataset,1);
total = 0;
for i =1:userNum 
    total = total + sum(dataset(i,targetService,:));
end
avgService = total/(userNum*num);
%%����Ŀ���û����ڷ����ƽ��ֵ
serviceNum = size(dataset,2);
totalS = 0;
for i =1:serviceNum
    totalS = totalS + sum(dataset(targetUser,i,:));
end
avgUser = totalS/(serviceNum*num);
%%���������
count = num*k;
MAE_delta = sum(abs(pM1(:)- rM(:)))/ count;
MAE_deltaS = sum(abs(pM2(:)- rM(:)))/ count;
MAE_Hy = sum(abs(pM3(:)- rM(:)))/ count; %���Ԥ��
MAE_avg1 = sum(abs(avgService*ones(count,1) - rM(:)))/ count;
MAE_avg2 = sum(abs(avgUser*ones(count,1) - rM(:)))/ count;
RMSE_delta=sqrt(sum((pM1(:)- rM(:)).^2)/count);
RMSE_deltaS=sqrt(sum((pM2(:)- rM(:)).^2)/count);
RMSE_Hy = sqrt(sum((pM3(:)- rM(:)).^2)/count); %���Ԥ��
RMSE_avg1=sqrt(sum((avgService*ones(count,1) - rM(:)).^2)/count);
RMSE_avg2=sqrt(sum((avgUser*ones(count,1) - rM(:)).^2)/count);