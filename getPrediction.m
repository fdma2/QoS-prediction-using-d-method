function prediction = getPrediction(targetUser,targetService,rt)
%找到目标用户所使用过的所有的服务
%找到候选用户
candidateUsers = find(rt(:,targetService,1)~=0);
uNum = size(candidateUsers,1);
%找到候选服务
candidateServices =find(rt(targetUser,:,1)~=0);
sNum = size(candidateServices,1);
if(uNum==0 && sNum==0)
    disp('没有相似的用户或相似的服务！')
    prediction = NAN;
    return;
end
%##########用相似的用户的预测结果################
s = cell(uNum,1);
for i =1:uNum
    s{i} = getSequence(candidateUsers(i),targetService,rt);
end
%获取特征点序列
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
%计算候选用户与目标用户的DTW距离
for i=1:uNum
    distance(i) = getDTW(newS{i},newS{targetUser});
end
%找到距离最小的相似用户的序列
[min1,idxUser] = min(distance);
%用距离最小的序列来预测
prediction1 = s{idxUser};
%%##########用相似的服务的预测结果################
ss2 = cell(sNum,1);
for i =1:sNum
    ss2{i} = getSequence(targetUser,candidateServices(i),rt);
end
%获取特征点序列
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
%计算候选用户与目标用户的DTW距离
for i=1:sNum
    distance2(i) = getDTW(newSS2{i},newSS2{targetService});
end
%找到距离最小的相似服务序列
[min2,idxService] = min(distance2);
%用距离最小的服务序列来预测
prediction2 = ss2{idxService};
%选择距离最小的来预测
if(min1>=min2)
    prediction =prediction2;
else
    prediction = prediction1;
end
end