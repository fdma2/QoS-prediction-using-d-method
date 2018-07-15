function createfigure(X1, YMatrix1)
%CREATEFIGURE(X1, YMATRIX1)
%  X1:  x ���ݵ�ʸ��
%  YMATRIX1:  y ���ݵľ���

%  �� MATLAB �� 15-Jan-2018 08:26:23 �Զ�����

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ʹ�� plot �ľ������봴������
plot1 = plot(X1,YMatrix1,'LineWidth',1,'Parent',axes1);
set(plot1(1),'DisplayName','FFM1','MarkerFaceColor',[1 0 0],'Marker','o',...
    'Color',[1 0 0]);
set(plot1(2),'DisplayName','FFM2','MarkerFaceColor',[1 0 0],'Marker','o',...
    'Color',[1 0 0]);
set(plot1(3),'DisplayName','UMEAN','MarkerFaceColor',[0 0 1],...
    'Marker','square',...
    'Color',[0 0 1]);
set(plot1(4),'DisplayName','IMEAN','MarkerFaceColor',[0 1 0],'Marker','>',...
    'Color',[0 1 0]);

% ���� xlabel
xlabel({'Matrix Density'},'FontSize',11);

% ���� ylabel
ylabel({'RMSE'},'FontSize',11);

box(axes1,'on');
grid(axes1,'on');
% ���� legend
legend(axes1,'show');

