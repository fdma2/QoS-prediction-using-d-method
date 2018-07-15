function MAE = doExperiments(density,dataset,k)
%函数功能：运行实验
%输入：矩阵密度，数据集,要预测的数量
%输出：MAE，RMSE
%生成之后的矩阵
preData= generateData(density,dataset);
%随机预测10个序列
num = k*size(dataset,3);
[x,y] = find(preData(:,:,1)==0);
n = numel(x);
randx = x(ceil(rand(1,k)*n));
predict = [x(randx),y(randx)];
predictValue = cell(k,1);
realValue = cell(k,1);
accurancy = zeros(k,1);
for i=1:k
    targetUser =  predict(k,1);
    taegetService = predict(k,2);
    predictValue{k} = getPrediction(targetUser,taegetService,preData);
    realValue{k} = dataset(targetUser,tagetService,:);
    accurancy(k) = sum(abs(predictValue{k} - realValue{k}));
end
MAE  = sum(accurancy)/ num;