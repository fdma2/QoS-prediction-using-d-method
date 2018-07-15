function [MAE ,RMSE,MAE_avg2real]= runFile(density,dataset,k)
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
%%  flag�ж��Ƿ���Ŀ����������0��ֵ������
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
    fprintf('regenerating new k none-zero array,time:%d\n',gtime);    %����������������У���ʾ�������ɵĴ���
end
%% 
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
    realValue{i} = reshape(dataset(targetUser,targetService,:),[64,1]);     % �����д������� 1X1X64�ľ���, �Ѹ�Ϊreshape
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
end 
%������е�Ԥ��ֵ
pM = zeros(num, k);
%������е���ʵֵ
rM = zeros(num,k);
for i =1:k
    pM(:,i) = predictValue{i};
    rM(:,i) = realValue{i};
end
%% ���¼���Ŀ������������û���ƽ��ֵ
userNum = size(dataset,1);
total = 0;
for i =1:userNum 
    total = total + sum(dataset(i,targetService,:));
end
avgService = total/(userNum*num);
%%���������
MAE  = sum(abs(pM(:) - rM(:)))/ (num*k);
MAE_avg2real = sum(abs(avgService*ones(num*k,1) - rM(:)))/ (num*k);
RMSE=sqrt(sum((pM(:) - rM(:)).^2)/(num*k));
errorDis = pM(:) - rM(:);
% save errorDis;   