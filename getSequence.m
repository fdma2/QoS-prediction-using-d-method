function seq = getSequence(targetUser,targetService,rt)
%从数据集中获取序列
%输入：目标用户，目标服务
%输出：这个用户使用该服务的时间序列
s = rt(targetUser,targetService,:);
timeNum = size(s,3);
s = reshape(s,timeNum,1);
timeSeq = 1:timeNum;
timeSeq = timeSeq';
seq = [timeSeq,s];