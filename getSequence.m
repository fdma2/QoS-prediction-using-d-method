function seq = getSequence(targetUser,targetService,rt)
%�����ݼ��л�ȡ����
%���룺Ŀ���û���Ŀ�����
%���������û�ʹ�ø÷����ʱ������
s = rt(targetUser,targetService,:);
timeNum = size(s,3);
s = reshape(s,timeNum,1);
timeSeq = 1:timeNum;
timeSeq = timeSeq';
seq = [timeSeq,s];