plot(x, y);

xlabel('距离锚的水平距离/m')
ylabel('距离锚的竖直距离/m')
axis([0 18.01 0 12.5])
set(gca, 'XTick', (0: 18));
set(gca, 'YTick', (0: 12.5));
grid off