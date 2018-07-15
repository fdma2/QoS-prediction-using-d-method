function preMatrix = generateData(percent,rt)
%功能：生成一个矩阵，是原数据的密度为percent的矩阵
%总数据：size(rt,1)*size(rt,2)
%输入：百分比，原始数据,eg.(0.1,rt)
%输出：size(rt,1)*size(rt,2)/percent
ratio = percent;
user = size(rt,1);
service = size(rt,2);
k = floor(user*service*ratio);
n = user*service;%A中元素的个数
%取得矩阵中随机的k个值的编号
p=randperm(n,k);
A = zeros(user,service);
A(p) = 1;
preMatrix = A.*rt;
end