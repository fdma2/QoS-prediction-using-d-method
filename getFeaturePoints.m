%����S��һ������
function fp = getFeaturePoints(startIdx,endIdx,S)
%���ȼ�����λ�������,�õ�ֱ�߷���
global bool;
[a,b] = CalculateDis(S(startIdx,:),S(endIdx,:));
disVID = abs(S(startIdx:endIdx,1)*a+b-S(startIdx:endIdx,2));
[~,middleIdx] = max(disVID);
if(bool==1)
    fp = middleIdx+startIdx;
else
    fp = middleIdx;
end
left = middleIdx - startIdx;
right = endIdx - middleIdx;
if(left>=3)
    bool= 0;
    fp = [fp,getFeaturePoints(startIdx,middleIdx+startIdx,S)];
end
if(right>=3)
    bool= 1;
    fp = [fp,getFeaturePoints(middleIdx,endIdx,S)];
end
if(left<3&&right<3)
    return;
end

    

