% https://www.mathworks.com/help/map/ref/addcustombasemap.html
addpath('E:\jhuai\tools\export_fig');
trk = geopoint([39.9042 38.0428 30.5928], [116.4074 114.5143 114.3052],...
    'Name', {"Beijing", "Shijiazhuang", "Wuhan"});

baseURL = "https://basemap.nationalmap.gov/ArcGIS/rest/services";
usgsURL = baseURL + "/BASEMAP/MapServer/tile/${z}/${y}/${x}";
basemaps = ["USGSImageryOnly"]; % "USGSImageryTopo" "USGSTopo" "USGSHydroCached"];

displayNames = ["USGS Imagery", "USGS Topographic Imagery", "USGS Shaded Topographic Map"];
maxZoomLevel = 16;
attribution = "Credit: U.S. Geological Survey";
close all;
for k =1:length(basemaps)
    basemap = basemaps(k);
    name = lower(basemap);
    url = replace(usgsURL,"BASEMAP",basemap);
    displayName = displayNames(k);
    addCustomBasemap(name,url,"Attribution",attribution, ...
        "DisplayName",displayName,"MaxZoomLevel",maxZoomLevel)
    f = figure;
    f.Position(2) = f.Position(2) * 0.5;
    f.Position(3:4) = f.Position(3:4) * 1.8;
    gx = geoaxes;
    geoplot(gx, trk.Latitude,trk.Longitude,"pr","LineWidth",2);
    geobasemap(basemap);

    deltalon = 0.8;
    text(trk.Latitude(1),trk.Longitude(1) - deltalon, trk.Name(1),...
        'HorizontalAlignment','right',...
        'VerticalAlignment','bottom', 'Color', 'white');
    text(trk.Latitude(2),trk.Longitude(2) - deltalon, trk.Name(2),...
        'HorizontalAlignment','right',...
        'VerticalAlignment','bottom', 'Color', 'white');
    text(trk.Latitude(3),trk.Longitude(3) - deltalon,trk.Name(3),...
        'HorizontalAlignment','right',...
        'VerticalAlignment','bottom', 'Color', 'white');

    dlat = 0.75;
    dlon = dlat * 2;
    geolimits([18.172 - dlat 53.566 + dlat], [73.51 - dlon 134.77 + dlon]);

    % set gx properties as found here
    % https://www.mathworks.com/help/matlab/ref/matlab.graphics.axis.geographicaxes-properties.html
    gx.LongitudeLabel.String = ['Longitude (', char(176), ')'];
    gx.LatitudeLabel.String = ['Latitude (' char(176) ')'];
    gx.FontName = 'Times';
    set(gcf, 'Color', 'none');
    pause(1); % wait for internet connection.
    filename = strcat('output/china-', basemap, '.png');
    delete(filename);

    export_fig(filename);
end

