function [ scale_value ] = user_scale_cal( dataset,targetUser,targetService,best_user)
tmp =size(dataset,2);                                                                                                                                                                                                                                                                                                                                                                                                                                                        scale_value = zeros(size(dataset,3),1);
times_num =zeros(tmp,1);
total_best_user = zeros(tmp,1);
total_target_user = zeros(tmp,1);
for j = 1:size(dataset,2)
    if sum(abs(dataset(best_user,j,:))) == 0 || sum(abs(dataset(targetUser,j,:))) == 0 || j == targetService  %if one of the two value is 0,   jump to next loop
            continue;
    end
    for k = 1:size(dataset,3)
        if dataset(best_user,j,k) == 0 || dataset(targetUser,j,k) == 0     % exclude all the zeros
            continue;
        else
            total_best_user(j) = total_best_user(j) + dataset(best_user,j,k);
            total_target_user(j) = total_target_user(j) + dataset(targetUser,j,k);
            times_num(j) = times_num(j) + 1;
        end
    end
end
scale_value = sum(total_target_user)/sum(total_best_user);
end