function [MAE ,RMSE]= runFile(density,dataset,k)
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
randx = randperm(n,k);
predict = [x(randx),y(randx)];
predictValue = cell(k,1);
realValue = cell(k,1);
% accurancy = zeros(k,1);
for i=1:k
    targetUser =  predict(i,1);
    targetService = predict(i,2);
    [userID,serviceID] = getSimilarUserAndService(targetUser,targetService,preData,density);
    tmp = getSequence(userID,targetService,preData); 
    tmp2 = getSequence(targetUser,serviceID,preData);
    predictValue{i} = tmp(:,2);   %这里有错误，这是64 X 2的矩阵, 后面已经用第二列进行计算
    realValue{i} = reshape(dataset(targetUser,targetService,:),[64,1]); 
    %如果目标为0，那么预测也为0，减少误差
    if(sum(dataset(targetUser,targetService,:))==0)
        predictValue{i} = realValue{i};
    end
    %#################开始画图###################
    %用相似用户预测
    plot(tmp2(:,1),tmp2(:,2),'g+');
    hold on
    %用相似服务预测
    plot(tmp(:,1),predictValue{i},'rx');
    hold on
    plot(tmp(:,1),realValue{i},'b<');   
%     hold on 
%     diff = realValue{i};
% %     for m=1:64   
%         plot([m,m],[tmp(m,2),diff(m)],'k-');
%     end
    close;
    %################end#######################
end
%获得所有的预测值
pM = zeros(num, k);
%获得所有的真实值
rM = zeros(num,k);
for i =1:k
    pM(:,i) = predictValue{i};
    rM(:,i) = realValue{i};
end
MAE  = sum(abs(pM(:) - rM(:)))/ (num*k);
RMSE=sqrt(sum((pM(:) - rM(:)).^2)/(num*k));
errorDis = pM(:) - rM(:);
save errorDis;