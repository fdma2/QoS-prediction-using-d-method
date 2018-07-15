function s_point = cal_sp(start,stop,S)
if nargin <3
    s_point = -1;
    return;
end
sub_array = S(start:stop,1:end);
[a,b] = CalculateDis(sub_array(1,:),sub_array(end,:));
disVID = abs(sub_array(1:end,1)*a+b-sub_array(1:end,2));
[~,delta] = max(disVID);%得到序列<1,10>的一个特征点
s_point = start + delta - 1;
end

function [a,b] = CalculateDis(P1,P2)
x1=P1(1,1);
y1=P1(1,2);
x2=P2(1,1);
y2=P2(1,2);
a = (y1-y2)/(x1-x2);
b = (x1*y2 - x2*y1)/(x1 - x2)';
end