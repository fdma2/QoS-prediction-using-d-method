%做实验记录每次的MAE和RMSE
%下次可以换成NMAE和RMSE
%每次都固定好target，然后算完之后再计算MAE和RMSE

function [predictValue_delta,predictService_delta,predictService_hy,avgService,avgUser]= getResults(dataset,targetUser,targetService,weight)
%函数功能：预测同一个序列的数据集
%输入：抽取之后的数据集，原始的数据集，目标用户，目标服务，权重
%输出：预测之后的值
%包括五种方法：基于用户的预测、基于服务的预测、混合预测方法、均值1，均值2
num = size(dataset,3);
%% 找到最相似的服务或者用户
[userID,serviceID] = getSimilarUserAndService(targetUser,targetService,dataset);
predictValue = reshape(dataset(userID,targetService,:),[64,1]);   
predictService = reshape(dataset(targetUser,serviceID,:),[64,1]);   
deltaP = user_scale_cal(dataset,targetUser,targetService,userID);
deltaS = service_delta_cal(dataset,targetUser,targetService,serviceID);
predictValue_delta =  predictValue*deltaP;
predictService_delta = predictService*deltaS; 
predictService_hy = predictValue_delta*weight+ predictService_delta*(1-weight);
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
for k =1:serviceNum
    totalS = totalS + sum(dataset(targetUser,k,:));
end
avgUser = totalS/(serviceNum*num);