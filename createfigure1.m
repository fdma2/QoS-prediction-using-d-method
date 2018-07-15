function createfigure1(X1, YMatrix1)
%CREATEFIGURE1(X1, YMATRIX1)
%  X1:  x 数据的矢量
%  YMATRIX1:  y 数据的矩阵

%  由 MATLAB 于 15-Jan-2018 09:55:24 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 使用 plot 的矩阵输入创建多行
plot1 = plot(X1,YMatrix1,'LineWidth',2,'Parent',axes1);
set(plot1(1),'DisplayName','FFM1','MarkerFaceColor',[1 0 0],'Marker','o',...
    'Color',[1 0 0]);
set(plot1(3),'DisplayName','UMEAN','MarkerFaceColor',[0 0 1],...
    'Marker','square',...
    'Color',[0 0 1]);
set(plot1(4),'DisplayName','IMEAN','MarkerFaceColor',[0 1 0],'Marker','>',...
    'Color',[0 1 0]);
set(plot1(2),'DisplayName','FFM2','MarkerFaceColor',[0 0 0],'Marker','o',...
    'Color',[0 0 0]);

% 创建 xlabel
xlabel({'Matrix Density'},'FontSize',16,'FontName','Times New Roman');

% 创建 title
title({'Respond Time'},'FontSize',17.6);

% 创建 ylabel
ylabel({'MAE'},'FontSize',16,'FontName','Times New Roman');

box(axes1,'on');
grid(axes1,'on');
% 设置其余坐标轴属性
set(axes1,'FontName','Times New Roman','FontSize',16,'XTickLabel',...
    {'5%','10%','15%','20%','25%','30%','35%','40%','45%','50%'});
% 创建 legend
legend1 = legend(axes1,'show');
set(legend1,...
    'Position',[0.802905425186918 0.68400224492972 0.0996323529411762 0.099198557754407],...
    'FontSize',10);

