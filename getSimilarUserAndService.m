function [userID,serviceID] = getSimilarUserAndService(targetUser,targetService,rt)
% data = generateData(percent,rt);
data = rt;
[missing_user,missing_service] = find(data(:,:,1) == 0);
if nargin <3
    user_id_random = randperm(length(missing_user),1);    % find a random missing sample to get prediction
    targetUser = missing_user(user_id_random);
    targetService = missing_service(user_id_random);
    fprintf('random select missing U-S is user: %d , service: %d\n', targetUser,targetService);
%     fprintf('data remain percent is %0.2f\n', percent);
end
[num_user , num_service , num_time] = size(rt);
matrix_user_compare_flag = zeros(num_user , num_service);
matrix_user_compare_value = zeros(num_user , num_service);
user_similar_value = zeros(1,num_user);
user_compared_num = zeros(1,num_user);

%%====find simialr user====================
for i = 1:num_user
    if i == targetUser
        user_similar_value(i) = inf;    %excluse the target user
        continue;
    elseif sum(abs(rt(i,targetService,1))) == 0    % if the target service in this user is empty ,then exclude this user
        user_similar_value(i) = inf;
        continue;
    end
    for j = 1:num_service
        if sum(abs(rt(i,j,:))) == 0 || sum(abs(rt(targetUser,j,:))) == 0  %if one of the two value is 0,   jump to next loop
            continue;
        end
        %新版
        matrix_user_compare_flag(i,j) = 1;
        temp_service_quality = reshape(rt(i,j,:),[num_time,1]);
%         temp_service_quality_s = getSequence(i,j,rt);
%         %获取特征序列
%         tmp_1 = getFP(temp_service_quality_s);
        target_service_quality = reshape(rt(targetUser,j,:),[num_time,1]);
%         temp_service_quality_s2 = getSequence(targetUser,j,rt);
%         tmp_2 = getFP(temp_service_quality_s2);
        matrix_user_compare_value(i,j) = getDTW(temp_service_quality , target_service_quality);
        user_compared_num(i) = user_compared_num(i) + 1;
    end
    if user_compared_num(i) == 0    % if there is no none-zero value, then similar value get infinite value
        user_similar_value(i) = inf;
    else
        user_similar_value(i) = sum(matrix_user_compare_value(i,:))/user_compared_num(i);
    end
end
[ ~, best_user] = min(user_similar_value);
userID = best_user;
%%====find simialr user finish================


%%====find similar service==================
matrix_service_compare_flag = zeros(num_user , num_service);
matrix_service_compare_value = zeros(num_user , num_service);
service_similar_value = zeros(1,num_service);
service_compared_num =zeros(1,num_service);
for j = 1: num_service
    if j == targetService
        service_similar_value(j) = inf;   %excluse the target service
        continue;
    elseif sum(abs(rt(targetUser,j,1))) == 0
        service_similar_value(j) = inf;  % if the target user in this service is empty ,then exclude this service
        continue;
    end
    for i = 1: num_user
        if sum(abs(rt(i,j,1))) == 0 || sum(abs(rt(i,targetService,1))) == 0  %if one of the two value is 0,   jump to next loop
            continue;
        end
%         matrix_service_compare_flag(i,j) = 1;
%         temp_service_quality = reshape(rt(i,j,:),[num_time,1]);
%         target_service_quality = reshape(rt(i,targetService,:),[num_time,1]);
%         matrix_service_compare_value(i,j) = getDTW(temp_service_quality , target_service_quality);
        
        matrix_service_compare_flag(i,j) = 1;
        temp_service_quality = reshape(rt(i,j,:),[num_time,1]);
%         temp_service_quality_s = getSequence(i,j,rt);
%         %获取特征序列
%         tmp_1 = getFP(temp_service_quality_s);
        target_service_quality = reshape(rt(i,targetService,:),[num_time,1]);
%         temp_service_quality_s2 = getSequence(i,targetService,rt);
%         tmp_2 = getFP(temp_service_quality_s2);
        matrix_service_compare_value(i,j) = getDTW(temp_service_quality , target_service_quality);
        service_compared_num(j) = service_compared_num(j) + 1;
    end
    if service_compared_num(j) == 0    % if there is no none-zero value, then similar value get infinite value
        service_similar_value(j) = inf;
    else
        service_similar_value(j) = sum(matrix_service_compare_value(:,j))/service_compared_num(j);
    end
end
[~ , best_service] = min(service_similar_value);
serviceID = best_service;
%%====find similar service finish==============
fprintf('target:%d,	%d\n', targetUser,targetService);
fprintf('best  :%d, %d            compare:%d, %d\n', userID,serviceID,user_compared_num(userID),service_compared_num(serviceID));