function fp = getFP(S)
%�������ܣ���ȡ���е�������
%���룺 һ��ʱ������
%�����ԭʼ���е�������
len=size(S,1);
idx = zeros(1,len);
idx(1)=1;
idx(end)=1;
flag = 1;
while flag ==1
    flag = 0;
    [~,idx_one] = find(idx>0);
    if isempty(idx_one==0) 
        break;
    end
    for i=2:length(idx_one)
        if idx_one(i) - idx_one(i-1)<=3
            continue;
        else
            flag = 1;
            start = idx_one(i-1);
            stop = idx_one(i);
            s_point = cal_sp(start,stop,S);
            idx(s_point) = 1;
        end
    end
end
fp = idx_one';