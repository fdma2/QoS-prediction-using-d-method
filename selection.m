function rank = selection(A,B,w)
%AΪ��Ӧʱ�����BΪ����������
%rankΪ�������,wΪ��һ������ļ�Ȩ
%A�ĸ�ʽΪn*t ��ά���� nΪ�������� tΪʱ��Ƭ������
%��������
%1. ���Ƚ��й�һ����2. �����Ȩ�����û����߾��� 3. ����QoS��̬����<��ֵ����׼��> 4.
%������A+��A-�ľ��룬5�����������������������õ�����
n=size(A,1);
%�ȶ�A(��Ӧʱ��)���й�һ������
normA = (max(A(:))-A)/(max(A(:))-min(A(:)));
%�ٶ�B�������������й�һ��
normB= (B-min(B(:)))/(max(B(:))-min(B(:)));
%������߾���
Q=w*normA + (1-w)*normB;
%��ֵ����
E= mean(Q,2); %����ÿһ�еľ�ֵ
S = std(Q,0,2); %����ÿһ�еı�׼��
%��̬����
DynamicM = [E S];
posA = [1 0]; negA = [0 0];
d = zeros(n,1);
for i=1:n
    d(i)=dist(DynamicM(i,:),negA')/(dist(DynamicM(i,:),posA')+dist(DynamicM(i,:),negA'));
end
[~,rank] =sort(d);
%rank��������
end