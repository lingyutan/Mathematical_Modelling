t = 0 : 0.1 : 17.6;
F = zeros(size(t, 2), 1);
for i = 1 : size(t, 2)
    F(i) = 3.0614*1359.1837/(1+3.0614/2940*t(i));
end
plot(t, F)
title('��F�仯����ͼ', 'FontSize', 16)
xlabel('ʱ��/t');
ylabel('��/N');
axis([0 17.6 4080 4180])

% m = 1359.1837;
% for i = 1 : size(t, 2) - 1
%     m = m - F(i)/2940*0.1;
% end
