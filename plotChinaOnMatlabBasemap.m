% https://www.mathworks.com/help/matlab/ref/geoaxes.html
% Note we may also use matplotlib to draw the geomaps as discussed here
% https://stackoverflow.com/questions/64020950/how-to-use-basemap-and-matplotlib-to-display-only-a-detailed-map-of-a-country

% beijing 39.9042° N, 116.4074° E
% shijiazhuang 38.0428° N, 114.5143° E
% wuhan 30.5928° N, 114.3052° E
addpath('E:\jhuai\tools\export_fig');
p = geopoint([39.9042 38.0428 30.5928], [116.4074 114.5143 114.3052],...
       'Name', {"Beijing", "Shijiazhuang", "Wuhan"});

close all;
% worldmap china
% geoshow('landareas.shp','FaceColor', [0.15 0.5 0.15])
% geoshow(p)


basemaps = {'darkwater', 'grayland', 'bluegreen', 'grayterrain', ...
    'colorterrain', 'landcover', 'streets', 'streets-light', ...
'streets-dark', 'satellite', 'topographic', 'usgstopo', ...
'usgsimageryonly', 'usgsimagerytopo', 'usgshydrocached', ...
'opentopomap', 'none'};

basemaps = {'bluegreen', 'colorterrain', 'darkwater', 'grayland', 'landcover'};

basemaps = {'colorterrain'};
fontname = 'SansSerif'; % 'Times'
fontsize = 16;

for i=1:length(basemaps)
f = figure;
f.Position(1:2) = f.Position(1:2) * 0.2;
f.Position(3:4) = f.Position(3:4) * 1.8;
gx = geoaxes;
geoplot(gx, p.Latitude,p.Longitude,'hr','LineWidth', 2);

basemapname = basemaps{i};
geobasemap(gx, basemapname); 

text(p.Latitude(1),p.Longitude(1),p.Name(1),...
    'HorizontalAlignment','right',...
    'VerticalAlignment','bottom', 'FontName', fontname, 'FontSize', fontsize);
text(p.Latitude(2),p.Longitude(2),p.Name(2),...
    'HorizontalAlignment','right',...
    'VerticalAlignment','bottom', 'FontName', fontname, 'FontSize', fontsize);
text(p.Latitude(3),p.Longitude(3),p.Name(3),...
    'HorizontalAlignment','right',...
    'VerticalAlignment','bottom', 'FontName', fontname, 'FontSize', fontsize);
dlat = 0.75;
dlon = dlat * 2;
geolimits([18.172 - dlat 53.566 + dlat], [73.51 - dlon 134.77 + dlon]);
% set gx properties as found here
% https://www.mathworks.com/help/matlab/ref/matlab.graphics.axis.geographicaxes-properties.html
gx.LongitudeLabel.String = ['Longitude (', char(176), ')'];
gx.LatitudeLabel.String = ['Latitude (' char(176) ')'];
gx.FontName = fontname;
gx.FontSize = fontsize;
% https://www.mathworks.com/help/matlab/ref/matlab.graphics.axis.decorator.geographicscalebar-properties.html
gx.Scalebar.Visible = 'on';
gx.Scalebar.LineWidth = 2;
gx.Scalebar.FontName = fontname;
gx.Scalebar.FontSize = fontsize;
% gx.ZoomLevel = 4.1;

set(gcf, 'Color', 'none');
pause(1); % wait for internet connection.
filename = ['output/china-' basemapname '.png'];
delete(filename);
export_fig(filename);
end