clc
clear

data = load('Fluence_Distribution_1550nm_Cochlear_7.8E10_500ms.mat');



levels = log10(abs(squeeze(data.CWfluence(:,ceil(data.y_plane),:))'));


y_plane=data.y_plane;   
[xx,zz]=meshgrid(1:size(data.USC_atlas,1),1:size(data.USC_atlas,3));

% plot CW fluence distribution using contour lines
name = 'Fluence_Distribution_1550nm_Cochlear_7.8E10_500ms';
figure('Name', name,'units','normalized','outerposition',[0 0 1 1]);

clines=-20:0.5:0;
contourf(xx,zz,log10(abs(squeeze(data.CWfluence(:,ceil(y_plane),:))')),clines,'linestyle','--','color',[0.9100    0.4100    0.1700],'linewidth',1.5,'DisplayName','MCX');
hold on;axis equal;
colorbar('EastOutside');

% plot tissue boundary contour, source, legend, etc.
contour(squeeze(data.USC_atlas(:,ceil(y_plane),:))','k--','linewidth',1.25,'HandleVisibility','off');
plot(data.cfg.srcpos(1,1),data.cfg.srcpos(1,3),'o','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',10,'DisplayName','source');

lg=legend('Location','northeast');
set(lg,'color','[0.85 0.85 0.85]');
set(lg,'box','on');
hold on;
% set(gca,'ylim', [160 225]);ylabel('z [mm]');
% set(gca,'xlim', [10 165]);xlabel('x [mm]');
% set(gca,'clim',[-12 0]);
set(gca,'fontsize',18);
set(gca, 'FontName', 'Times New Roman');


r1 = drawrectangle('Label','OuterRectangle','Color','red');
% get the x and y coordinates of the rectangle
%[x1, y1] = [r1.Position(1) r1.position(2)];
%[x2, y2] = [r1.Position(3) r2.position(4)];

x1 = round(r1.Position(1));
x2 = round(r1.Position(3) + x1);

y1 = r1.Position(2);
y2 = round(r1.Position(4) + y1);
y1_rounded = round(y1);

x1_rounded = round(x1); 

level_at_x1_1 = levels(x1_rounded, y1_rounded);

levels_array = levels(x1: round(x2), y1_rounded: y2);
avga = mean(levels_array, 'all');

% add text annotations
legend_str = sprintf('Area: %d\nAverage (fluence level): %d\n Average Energy(fluence * area) %d', (x2-x1)*(y2-y1), avga, 10^avga*(x2-x1)*(y2-y1));
lg=legend(legend_str, 'Location','northwest');


% update text annotations when rectangle is moved


%fprintf('myachikne: %d\n' , level_at_x1_1);



% print out the x and y coordinates
%dimensions = [abs(y2 - x1) abs(y2-y1)];



%fprintf('x1 rounded: %d\n', x1_rounded);

%fprintf('dimension: %d x %d\n', dimensions(1), dimensions(2));

%fprintf('x y coord: %d %d %d %d\n', x1, y1, x2, y2);

%area = dimensions(1) * dimensions(2);
%fprintf('area: %d\n', area);
%avga = mean(levels_array, 'all');
%fprintf('average: %d \n', avga);





