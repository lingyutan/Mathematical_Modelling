% 此程序用于模拟锚链形状部分

%-----------注意----------%
% 部分参数定义在whole_system(main)函数中
% 需先运行主函数
%------------------------%

% clear, clc;

R = 1.25 * h2 * v^2;
L_sum = 22.05; % 锚链长度
w = 7; % 锚链单位长度质量
g = 9.80665;
a = R / (w * g);
theta = 0;
step = 0.001;
xmax = 20; %20

x = 0 : step : xmax;
y = a * (sec(theta)*(ch(x/a) - 1) + tan(theta)*sh(x/a));

% 测试导数
% y1 = a*((tan(theta)*cosh(x/a))/a + sinh(x/a)/(a*cos(theta)));
% d_angle = atan(y1)/pi*180;
% y2 = (sinh(x/a) + sin(theta)*cosh(x/a))/cos(theta);
% d_angle2 = atan(y2)/pi*180;

% plot(x, y);
% hold on
% plot(x, y1);

% for i = 1 : size(x, 2) - 1
%     d_angle_test(i) = atan((y(i+1) - y(i)) / step);
%     d_angle_test(i) = d_angle_test(i) / pi * 180;
% end

[~, Index] = min(abs(y - h_c));

% temp_x 锚链不在海床上部分的水平距离
temp_x = step * (Index - 1);

% L 为锚链长度
L = a*(tan(theta) * (ch(temp_x/a) - 1) + sec(theta) * sh(temp_x/a));

% % 测试锚链长度公式
% L_test = 0;
% for i = 1 : size(x, 2) - 1
%     L_test = L_test + sqrt(step^2 + (y(i+1) - y(i))^2);
% end

x_begin = x + L_sum - L;
plot(x + x_begin(1), y);
x_end = temp_x + x_begin(1);
axis([0 x_end 0 13])
title('');
xlabel('距离锚的水平距离/m')
ylabel('距离锚的竖直距离/m')
set(gca, 'XTick', [0: 15]);
set(gca, 'YTick', [0: 13]);

