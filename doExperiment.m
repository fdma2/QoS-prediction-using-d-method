%实验开始
%首先测试数据集rt
% close;clear;
% load rt;
% load tp;
mae_user = zeros(20,6);
mae_service =zeros(20,6);
mae_avgUser =zeros(20,6);
rmse_user =zeros(20,6);
rmse_service = zeros(20,6);
rmse_avgUser=zeros(20,6);
%runfile参数：密度，数据集，预测数量，top-k的k值
%第一组实验 误差率随着数据密度的变化 0.05-0.5
for  i=1:10
    [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,rt,1);
    mae_user(i,1) = MAE_user;
    mae_service(i,1) = MAE_service;
    mae_avgUser(i,1) = MAE_avgUser;
    rmse_user(i,1) = RMSE_user; 
    rmse_service(i,1) = RMSE_service;
    rmse_avgUser(i,1)= RMSE_avgUser;  
end
%第二遍
for  i=1:10
    [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,rt,1);
    mae_user(i,2) = MAE_user;
    mae_service(i,2) = MAE_service;
    mae_avgUser(i,2) = MAE_avgUser;
    rmse_user(i,2) = RMSE_user;
    rmse_service(i,2) = RMSE_service;
    rmse_avgUser(i,2)= RMSE_avgUser;
end
%第三遍
for  i=1:10
    [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,rt,1);
    mae_user(i,3) = MAE_user;
    mae_service(i,3) = MAE_service;
    mae_avgUser(i,3) = MAE_avgUser;
    rmse_user(i,3) = RMSE_user;
    rmse_service(i,3) = RMSE_service;
    rmse_avgUser(i,3)= RMSE_avgUser;
end
%第四遍
for  i=1:10
    [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,rt,1);
    mae_user(i,4) = MAE_user;
    mae_service(i,4) = MAE_service;
    mae_avgUser(i,4) = MAE_avgUser;
    rmse_user(i,4) = RMSE_user;
    rmse_service(i,4) = RMSE_service;
    rmse_avgUser(i,4)= RMSE_avgUser;
end
%第五遍
for  i=1:10
    [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,rt,1);
    mae_user(i,5) = MAE_user;
    mae_service(i,5) = MAE_service;
    mae_avgUser(i,5) = MAE_avgUser;
    rmse_user(i,5) = RMSE_user;
    rmse_service(i,5) = RMSE_service;
    rmse_avgUser(i,5)= RMSE_avgUser;
end
%第六遍
for  i=1:10
    [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,rt,1);
    mae_user(i,6) = MAE_user;
    mae_service(i,6) = MAE_service;
    mae_avgUser(i,6) = MAE_avgUser;
    rmse_user(i,6) = RMSE_user;
    rmse_service(i,6) = RMSE_service;
    rmse_avgUser(i,6)= RMSE_avgUser;
end

%第二个数据集做一样的实验
%第一组实验 误差率随着数据密度的变化 0.05-0.5
for  i=1:10
    [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,tp,1);
    mae_user(i+10,1) = MAE_user;
    mae_service(i+10,1) = MAE_service;
    mae_avgUser(i+10,1) = MAE_avgUser;
    rmse_user(i+10,1) = RMSE_user;
    rmse_service(i+10,1) = RMSE_service;
    rmse_avgUser(i+10,1)= RMSE_avgUser;
end
%第二遍
for  i=1:10
     [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,tp,1);
    mae_user(i+10,2) = MAE_user;
    mae_service(i+10,2) = MAE_service;
    mae_avgUser(i+10,2) = MAE_avgUser;
    rmse_user(i+10,2) = RMSE_user;
    rmse_service(i+10,2) = RMSE_service;
    rmse_avgUser(i+10,2)= RMSE_avgUser;
end
%第三遍
for  i=1:10
     [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,tp,1);
    mae_user(i+10,3) = MAE_user;
    mae_service(i+10,3) = MAE_service;
    mae_avgUser(i+10,3) = MAE_avgUser;
    rmse_user(i+10,3) = RMSE_user;
    rmse_service(i+10,3) = RMSE_service;
    rmse_avgUser(i+10,3)= RMSE_avgUser;
end

%第四遍
for  i=1:10
     [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,tp,1);
    mae_user(i+10,4) = MAE_user;
    mae_service(i+10,4) = MAE_service;
    mae_avgUser(i+10,4) = MAE_avgUser;
    rmse_user(i+10,4) = RMSE_user;
    rmse_service(i+10,4) = RMSE_service;
    rmse_avgUser(i+10,4)= RMSE_avgUser;
end
%第五遍
for  i=1:10
    [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,tp,1);
    mae_user(i+10,5) = MAE_user;
    mae_service(i+10,5) = MAE_service;
    mae_avgUser(i+10,5) = MAE_avgUser;
    rmse_user(i+10,5) = RMSE_user;
    rmse_service(i+10,5) = RMSE_service;
    rmse_avgUser(i+10,5)= RMSE_avgUser;
end
%第6遍
for  i=1:10
    [MAE_user ,MAE_service,MAE_avgUser,RMSE_user,RMSE_service,RMSE_avgUser]= runFile_delta(0.05*i,tp,1);
    mae_user(i+10,6) = MAE_user;
    mae_service(i+10,6) = MAE_service;
    mae_avgUser(i+10,6) = MAE_avgUser;
    rmse_user(i+10,6) = RMSE_user;
    rmse_service(i+10,6) = RMSE_service;
    rmse_avgUser(i+10,6)= RMSE_avgUser;
end
save