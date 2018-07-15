function testDensity(dataset,tp_sliced)
[targetUser,targetService] =findTarget(dataset);
mae1 = zeros(10,3);
mae2 =zeros(10,3);
mae3 =zeros(10,3);
mae4 =zeros(10,3);
mae5 = zeros(20,3);
rmse1=zeros(20,3);
rmse2 = zeros(20,3);
rmse3=zeros(20,3);
rmse4=zeros(20,3);
rmse5=zeros(20,3);
%测权重变化
for j=1:3
    for i=1:10
     [MAE_delta,MAE_deltaS,MAE_Hy,MAE_avg1 ,MAE_avg2,RMSE_delta,RMSE_deltaS,RMSE_Hy,RMSE_avg1,RMSE_avg2]= runFile_density(tp_sliced{i},dataset,targetUser,targetService,0.8);
        mae1(i,j) = MAE_delta;
        mae2(i,j) = MAE_deltaS;  
        mae5(i,j) = MAE_Hy;
        mae3(i,j) = MAE_avg1;
        mae4(i,j) = MAE_avg2;
        rmse1(i,j) = RMSE_delta; 
        rmse2(i,j) = RMSE_deltaS;
        rmse5(i,j) = RMSE_Hy;
        rmse3(i,j)= RMSE_avg1;  
        rmse4(i,j)= RMSE_avg2;  
    end
    [targetUser,targetService] =findTarget(dataset);
 end
%2：重新测试一个
plot([1:10],mae1(1:10,1),'ro');
