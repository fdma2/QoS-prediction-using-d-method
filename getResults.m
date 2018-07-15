%��ʵ���¼ÿ�ε�MAE��RMSE
%�´ο��Ի���NMAE��RMSE
%ÿ�ζ��̶���target��Ȼ������֮���ټ���MAE��RMSE

function [predictValue_delta,predictService_delta,predictService_hy,avgService,avgUser]= getResults(dataset,targetUser,targetService,weight)
%�������ܣ�Ԥ��ͬһ�����е����ݼ�
%���룺��ȡ֮������ݼ���ԭʼ�����ݼ���Ŀ���û���Ŀ�����Ȩ��
%�����Ԥ��֮���ֵ
%�������ַ����������û���Ԥ�⡢���ڷ����Ԥ�⡢���Ԥ�ⷽ������ֵ1����ֵ2
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