function [ user_delta ] = user_delta_cal( dataset,targetUser,targetService,best_user)
delta = zeros(size(dataset,3),1);
times_num =0;
for j = 1:size(dataset,2)
    if sum(abs(dataset(best_user,j,:))) == 0 || sum(abs(dataset(targetUser,j,:))) == 0 || j == targetService  %if one of the two value is 0,   jump to next loop
            continue;
    end
    delta = delta + reshape((dataset(best_user,j,:)-dataset(targetUser,j,:)),[size(dataset,3),1]);
    times_num = times_num + 1;
end
user_delta = sum(delta)/(size(dataset,3)*times_num);






