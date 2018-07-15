function [MAE_delta,MAE_deltaS,MAE_Hy,MAE_avg1 ,MAE_avg2,RMSE_delta,RMSE_deltaS,RMSE_Hy,RMSE_avg1,RMSE_avg2]= runFile_density(dataset,rt,targetUser,targetService,weight)
%�������ܣ�Ԥ��ͬһ�����е����ݼ�
%���룺��ȡ֮������ݼ���ԭʼ�����ݼ���Ŀ���û���Ŀ�����
%�����MAE��RMSE
%�������ַ����������û���Ԥ�⡢���ڷ����Ԥ��
num = size(dataset,3);
%% �ҵ������Ƶķ�������û�
[userID,serviceID] = getSimilarUserAndService(targetUser,targetService,dataset);
predictValue = reshape(dataset(userID,targetService,:),[64,1]);   
predictService = reshape(dataset(targetUser,serviceID,:),[64,1]);   
deltaP = user_scale_cal(dataset,targetUser,targetService,userID);
deltaS = service_delta_cal(dataset,targetUser,targetService,serviceID);
predictValue_delta =  predictValue*deltaP;
predictService_delta = predictService*deltaS; 
predictService_hy = predictValue_delta*weight+ predictService_delta*(1-weight);
realValue = reshape(rt(targetUser,targetService,:),[64,1]);
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
for k =1:serviceNum
    totalS = totalS + sum(dataset(targetUser,k,:));
end
avgUser = totalS/(serviceNum*num);
%%�������
MAE_delta = sum(abs(predictValue_delta- realValue))/ num;
MAE_deltaS = sum(abs(predictService_delta- realValue))/ num;
MAE_Hy = sum(abs(predictService_hy- realValue))/ num; %���Ԥ��
MAE_avg1 = sum(abs(avgService*ones(num,1) - realValue))/ num;
MAE_avg2 = sum(abs(avgUser*ones(num,1) - realValue))/ num;
RMSE_delta=sqrt(sum((predictValue_delta- realValue).^2)/num);
RMSE_deltaS=sqrt(sum((predictService_delta- realValue).^2)/num);
RMSE_Hy = sqrt(sum((predictService_hy- realValue).^2)/num); %���Ԥ��
RMSE_avg1=sqrt(sum((avgService*ones(num,1) - realValue).^2)/num);
RMSE_avg2=sqrt(sum((avgUser*ones(num,1) - realValue).^2)/num);