function preMatrix = generateData(percent,rt)
%���ܣ�����һ��������ԭ���ݵ��ܶ�Ϊpercent�ľ���
%�����ݣ�size(rt,1)*size(rt,2)
%���룺�ٷֱȣ�ԭʼ����,eg.(0.1,rt)
%�����size(rt,1)*size(rt,2)/percent
ratio = percent;
user = size(rt,1);
service = size(rt,2);
k = floor(user*service*ratio);
n = user*service;%A��Ԫ�صĸ���
%ȡ�þ����������k��ֵ�ı��
p=randperm(n,k);
A = zeros(user,service);
A(p) = 1;
preMatrix = A.*rt;
end