function [MAE ,RMSE]= runFile(density,dataset,k)
%�������ܣ�����ʵ��
%���룺�����ܶȣ����ݼ�,ҪԤ�������
%�����MAE��RMSE
%����֮��ľ���
%ʵ�����preData, ԭʼ����dataset
preData= generateData(density,dataset);
%���Ԥ��10������
%num = k*size(dataset,3);                                     %Ϊʲô��kX���г�
num = size(dataset,3);
[x,y] = find(preData(:,:,1)==0);
n = numel(x);
%randx = x(ceil(rand(1,k)*n));                            % 2018.01.10 0:41ע�ͣ� �����д���x�ǣ�n,1)�����У���ʹ�ã�1,k���������������µ����У����ֻ�ܵõ���һ����ֵ
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
    predictValue{i} = tmp(:,2);   %�����д�������64 X 2�ľ���, �����Ѿ��õڶ��н��м���
    realValue{i} = reshape(dataset(targetUser,targetService,:),[64,1]); 
    %���Ŀ��Ϊ0����ôԤ��ҲΪ0���������
    if(sum(dataset(targetUser,targetService,:))==0)
        predictValue{i} = realValue{i};
    end
    %#################��ʼ��ͼ###################
    %�������û�Ԥ��
    plot(tmp2(:,1),tmp2(:,2),'g+');
    hold on
    %�����Ʒ���Ԥ��
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
%������е�Ԥ��ֵ
pM = zeros(num, k);
%������е���ʵֵ
rM = zeros(num,k);
for i =1:k
    pM(:,i) = predictValue{i};
    rM(:,i) = realValue{i};
end
MAE  = sum(abs(pM(:) - rM(:)))/ (num*k);
RMSE=sqrt(sum((pM(:) - rM(:)).^2)/(num*k));
errorDis = pM(:) - rM(:);
save errorDis;