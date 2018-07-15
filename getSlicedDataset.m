%把数据集中，一个序列中超过20个为0，那么把整个序列都置0
%输入：数据集
%输出：新的数据集
function rt_sliced = getSlicedDataset(rt)
rt_sliced_temp = cell(20,1);
length = size(rt,3);
for i = 1:20
    rt_sliced_temp{i} = zeros(size(rt,1),size(rt,2),length);
end
rt_sliced = rt_sliced_temp;
for i = 1:size(rt,1)
    for j = 1:size(rt,2)
        for k = 1:length
            if rt(i,j,k) == 0 
                rt(i,j,:) =zeros(1,1,length);
                break;
            end
        end
        m = randperm(20,1);
        rt_sliced_temp{m}(i,j,:)=reshape(rt(i,j,:),[length,1]);
    end
end
for i = 1:20
    for j = 1:1:i
        rt_sliced{i}=rt_sliced{i}+rt_sliced_temp{j};
    end
end
end