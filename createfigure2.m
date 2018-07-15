function createfigure2(X1, YMatrix1)
%CREATEFIGURE2(X1, YMATRIX1)
%  X1:  x 数据的矢量
%  YMATRIX1:  y 数据的矩阵

%  由 MATLAB 于 15-Jan-2018 18:04:07 自动生成
% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 使用 plot 的矩阵输入创建多行
plot1 = plot(X1,YMatrix1,'Marker','o','LineWidth',2,'Parent',axes1);
set(plot1(1),'DisplayName','FFM1','MarkerFaceColor',[1 0 0],'Color',[1 0 0]);
set(plot1(2),'DisplayName','FFM2','MarkerFaceColor',[0 0 1],'Color',[0 0 1]);
set(plot1(3),'DisplayName','M2','MarkerFaceColor',[1 0 1],'Marker','<',...
    'Color',[1 0 1]);
set(plot1(4),'DisplayName','HY','MarkerFaceColor',[0 1 0],'Color',[0 1 0]);
set(plot1(5),'DisplayName','M1','MarkerFaceColor',[0 1 1],'Marker','>',...
    'Color',[0 1 1]);

% 创建 xlabel
xlabel({'Matrix Density'},'FontSize',17.6);

% 创建 title
title({'Respond Time'},'FontSize',17.6);

% 创建 ylabel
ylabel({'RMSE'},'FontSize',17.6);

grid(axes1,'on');
% 设置其余坐标轴属性
set(axes1,'FontSize',16,'XTickLabel',...
    {'5%','10%','15%','20%','25%','30%','35%','40%','45%','50%'});
% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.790808823529412 0.737173695768854 0.101102941176471 0.174617461746175],...
    'FontSize',14.4);

