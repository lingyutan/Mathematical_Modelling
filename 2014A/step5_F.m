t = 0 : 0.1 : 9.3;
F = zeros(size(t, 2), 1);

for i = 1 : size(t, 2)
    F(i) = 4.3747*1359.1837/(1+4.3747/2940*t(i));
end

plot(t, F)
title('��ֱ����F�仯����ͼ', 'FontSize', 16)
xlabel('ʱ��/t');
ylabel('��/N');
axis([0 9.3 5860 5950])

% m = 1312.3245;
% for i = 1 : size(t, 2) - 1
%     m = m - F(i)/2940*0.1;
% end
