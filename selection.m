function rank = selection(A,B,w)
%A为响应时间矩阵，B为吞吐量矩阵
%rank为输出矩阵,w为第一个矩阵的加权
%A的格式为n*t 二维矩阵。 n为服务数量 t为时间片的数量
%排名步骤
%1. 首先进行归一化，2. 计算加权矩阵，用户决策矩阵 3. 计算QoS动态矩阵<均值，标准差> 4.
%计算与A+和A-的距离，5，计算排名，最后进行排名得到服务
n=size(A,1);
%先对A(响应时间)进行归一化处理
normA = (max(A(:))-A)/(max(A(:))-min(A(:)));
%再对B（吞吐量）进行归一化
normB= (B-min(B(:)))/(max(B(:))-min(B(:)));
%计算决策矩阵
Q=w*normA + (1-w)*normB;
%均值矩阵
E= mean(Q,2); %计算每一行的均值
S = std(Q,0,2); %计算每一行的标准差
%动态矩阵
DynamicM = [E S];
posA = [1 0]; negA = [0 0];
d = zeros(n,1);
for i=1:n
    d(i)=dist(DynamicM(i,:),negA')/(dist(DynamicM(i,:),posA')+dist(DynamicM(i,:),negA'));
end
[~,rank] =sort(d);
%rank就是排名
end