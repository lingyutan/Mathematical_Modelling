t = 0 : 0.5 : 95;
Fy = zeros(size(t, 2), 1);

for i = 1 : size(t, 2)
    Fy(i) = 0.5090*1359.1837/(1+0.5090/2940*t(i));
end

plot(t, Fy)
title('��ֱ����F_y�仯����ͼ', 'FontSize', 16)
xlabel('ʱ��/t');
ylabel('��/N');
axis([0 95 680 692])

% m = 1334.4985;
% for i = 1 : size(t, 2) - 1
%     m = m - F(i)/2940*0.5;
% end
