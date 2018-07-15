function [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile5(density,dataset,k,top_num)
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
%  flag�ж��Ƿ���Ŀ����������0��ֵ������
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
%��ʼԤ��
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
    realValue{i} = reshape(dataset(targetUser,targetService,:),[64,1]);     % �����д������� 1X1X64�ľ���, �Ѹ�Ϊreshape
    %#################��ʼ��ͼ###################
    %�����Ʒ���Ԥ��
    plot(1:num,predictValue_service{i},'g+');
    hold on
    %�������û�Ԥ��
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
%������е�Ԥ��ֵ
uM = zeros(num, k);
%������е�Ԥ��ֵ
sM = zeros(num, k);
%������е���ʵֵ
rM = zeros(num,k);
for i =1:k
    uM(:,i) = predictValue{i};
    rM(:,i) = realValue{i};
    sM(:,i) = predictValue_service{i};
end
%% ���¼���Ŀ������������û���ƽ��ֵ
userNum = size(dataset,1);
total = 0;
for i =1:userNum 
    total = total + sum(dataset(i,targetService,:));
end
avgService = total/(userNum*num);
%% �������
MAE_user  = sum(abs(uM(:) - rM(:)))/ (num*k);
MAE_service  = sum(abs(sM(:) - rM(:)))/ (num*k);
MAE_avgUser= sum(abs(avgService*ones(num*k,1) - rM(:)))/ (num*k);
RMSE_user=sqrt(sum((uM(:) - rM(:)).^2)/(num*k));
RMSE_service=sqrt(sum((sM(:) - rM(:)).^2)/(num*k));
RMSE_avgUser=sqrt(sum((avgService*ones(num*k,1) - rM(:)).^2)/(num*k));