function [targetUser,targetService] = findTarget(dataset)
[m,n,o] = size(dataset);
targetUser = randperm(m,1);
targetService = randperm(n,1);
zero_flag = 0;
gtime = 0;
while zero_flag == 0
    zero_flag = 1;
    for k = 1:o
        if dataset(targetUser,targetService,k) == 0
            targetUser = randperm(m,1);
            targetService = randperm(n,1);
            gtime = gtime + 1;
            zero_flag = 0;
            break;
        end
    end
end
if gtime > 0
    fprintf('regenerating new k none-zero array,time:%d\n',gtime);    %如果有重新生成序列，显示重新生成的次数
end
end