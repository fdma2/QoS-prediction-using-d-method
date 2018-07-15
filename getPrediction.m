function prediction = getPrediction(targetUser,targetService,rt)
%�ҵ�Ŀ���û���ʹ�ù������еķ���
%�ҵ���ѡ�û�
candidateUsers = find(rt(:,targetService,1)~=0);
uNum = size(candidateUsers,1);
%�ҵ���ѡ����
candidateServices =find(rt(targetUser,:,1)~=0);
sNum = size(candidateServices,1);
if(uNum==0 && sNum==0)
    disp('û�����Ƶ��û������Ƶķ���')
    prediction = NAN;
    return;
end
%##########�����Ƶ��û���Ԥ����################
s = cell(uNum,1);
for i =1:uNum
    s{i} = getSequence(candidateUsers(i),targetService,rt);
end
%��ȡ����������
fp= cell(uNum,1);
for i=1:uNum
    fp{i} = getFP(s{i});
end
newS = cell(uNum,1);
for i=1:uNum
    tmp = s{i};
    newS{i} = [fp{i},tmp(fp{i},2)];
end
distance = zeros(uNum,1);
%�����ѡ�û���Ŀ���û���DTW����
for i=1:uNum
    distance(i) = getDTW(newS{i},newS{targetUser});
end
%�ҵ�������С�������û�������
[min1,idxUser] = min(distance);
%�þ�����С��������Ԥ��
prediction1 = s{idxUser};
%%##########�����Ƶķ����Ԥ����################
ss2 = cell(sNum,1);
for i =1:sNum
    ss2{i} = getSequence(targetUser,candidateServices(i),rt);
end
%��ȡ����������
fp2= cell(sNum,1);
for i=1:sNum
    fp2{i} = getFP(ss2{i});
end
newSS2 = cell(sNum,1);
for i=1:sNum
    tmp2 = ss2{i};
    newSS2{i} = [fp2{i},tmp2(fp2{i},2)];
end
distance2 = zeros(sNum,1);
%�����ѡ�û���Ŀ���û���DTW����
for i=1:sNum
    distance2(i) = getDTW(newSS2{i},newSS2{targetService});
end
%�ҵ�������С�����Ʒ�������
[min2,idxService] = min(distance2);
%�þ�����С�ķ���������Ԥ��
prediction2 = ss2{idxService};
%ѡ�������С����Ԥ��
if(min1>=min2)
    prediction =prediction2;
else
    prediction = prediction1;
end
end