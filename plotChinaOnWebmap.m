function plotChinaOnWebmap()
% https://www.mathworks.com/help/map/ref/addcustombasemap.html

name = 'opentopomap';
url = 'a.tile.opentopomap.org';
copyright = char(uint8(169));
attribution = [ ...
      "map data:  " + copyright + "OpenStreetMap contributors,SRTM", ...
      "map style: " + copyright + "OpenTopoMap (CC-BY-SA)"];
displayName = 'Open Topo Map';
addCustomBasemap(name,url,'Attribution',attribution, ...
                          'DisplayName',displayName)
% webmap opentopomap
% trk = gpxread('sample_mixed.gpx','FeatureType','track');
% wmline(trk,'LineWidth',2)
close all
wmclose all
cities = {"Beijing", "Shijiazhuang", "Wuhan"};
trk = geopoint([39.9042 38.0428 30.5928], [116.4074 114.5143 114.3052],...
       'Name', cities);

mapnames = {'World Physical Map'};
for i=1:length(mapnames)
webmap(mapnames{i}, 'WrapAround',false);
for j=1:length(cities)
    wmmarker(trk.Latitude(j), trk.Longitude(j));
end
dlat = 0.75;
dlon = dlat * 2;
wmlimits([18.172 - dlat 53.566 + dlat], [73.51 - dlon 134.77 + dlon]);
wmprint
end
end

function savedImageFile = createAnnotation(label)
A = 255*ones(64,144,3,'uint8'); % Or use your current marker You can also use geographic coordinates 
RGB = insertText(A, [1,10], label, 'TextColor','black', ...
    'BoxColor','red', 'BoxOpacity', 1.0, 'FontSize', 24, 'Font','Times New Roman Bold');
savedImageFile = strcat(label, '.png');
imwrite(RGB, savedImageFile);
end
