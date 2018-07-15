%把数据集中，一个序列中超过20个为0，那么把整个序列都置0
%输入：数据集
%输出：新的数据集
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