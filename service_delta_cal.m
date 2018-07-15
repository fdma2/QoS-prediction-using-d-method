function [ service_delta ] = service_delta_cal(dataset,targetUser,targetService,best_service)
delta = zeros(size(dataset,3),1);
times_num =0;
for i = 1:size(dataset,1)
    if sum(abs(dataset(i,best_service,:))) == 0 || sum(abs(dataset(i,targetService,:))) == 0 || i == targetUser  %if one of the two value is 0,   jump to next loop
        continue;
    end
    delta = delta + reshape((dataset(i,best_service,:)-dataset(i,targetService,:)),[size(dataset,3),1]);
    times_num = times_num + 1;
end
service_delta = sum(delta)/(size(dataset,3)*times_num);
end

