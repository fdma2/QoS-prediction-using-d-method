function createaxes(Parent1, X1, YMatrix1)
%CREATEAXES(PARENT1, X1, YMATRIX1)
%  PARENT1:  axes parent
%  X1:  x 数据的矢量
%  YMATRIX1:  y 数据的矩阵

%  由 MATLAB 于 15-Jan-2018 08:16:07 自动生成

% 创建 axes
axes1 = axes('Parent',Parent1);
hold(axes1,'on');

% 使用 plot 的矩阵输入创建多行
plot1 = plot(X1,YMatrix1,'LineWidth',1,'Parent',axes1);
set(plot1(3),'DisplayName','IMEAN','MarkerFaceColor',[0 1 0],'Marker','>','Color',[0 1 0]);
set(plot1(1),'DisplayName','FFM','MarkerFaceColor',[1 0 0],'Marker','o',...
    'Color',[1 0 0]);
set(plot1(2),'DisplayName','UMEAN','MarkerFaceColor',[0 0 1],...
    'Marker','square',...
    'Color',[0 0 1]);

% 创建 xlabel
xlabel({'Matrix Density'});

% 创建 title
title({''});

% 创建 ylabel
ylabel({'RMSE'});

grid(axes1,'on');
% 设置其余坐标轴属性
set(axes1,'XTickLabel',...
    {'5%','10%','15%','20%','25%','30%','35%','40%','45%','50%'});
