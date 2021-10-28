load coast;
h1=axesm('MapProjection','miller','Grid','on','MapLatLimit',[-60,60]);
framem('on');
gridm('on');
mlabel('north/29.7/2.6');
plabel('east/90.4/2.6');
hold on;
plotm(lat,long,'k');
worldmap()