%�����ݼ��У�һ�������г���20��Ϊ0����ô���������ж���0
%���룺���ݼ�
%������µ����ݼ�
function newRT = getNewDataset(rt)
for i = 1:size(rt,1)
    for j = 1:size(rt,2)
        zero_num = 0;
        for k = 1:size(rt,3)
            if rt(i,j,k) == 0 || rt(i,j,k) >=20
                zero_num = zero_num + 1;
            end
            if zero_num >=5
                rt(i,j,:) = zeros(1,1,size(rt,3));
                break;
            end
        end
    end
end
newRT = rt;
end