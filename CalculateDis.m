function [a,b] = CalculateDis(P1,P2)
x1=P1(1,1);
y1=P1(1,2);
x2=P2(1,1);
y2=P2(1,2);
a = (y1-y2)/(x1-x2);
b = (x1*y2 - x2*y1)/(x1 - x2)';
