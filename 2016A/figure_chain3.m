% �˳�������ģ��ê����״����
% ê�������ں�������

%-----------ע��----------%
% ���ֲ���������whole_system(main)������
% ��������������
%------------------------%

% clear, clc;

R = 1.25 * h2 * v^2;
L_sum = 22.05; % ê������
w = 7; % ê����λ��������
g = 9.80665;
a = R / (w * g);
step = 0.01;
xmax = 20; 

x = 0 : step : xmax;
y = a * (sec(theta)*(ch(x/a) - 1) + tan(theta)*sh(x/a));

% ���Ե���
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

% L Ϊê������
L = a*(tan(theta) * (ch(x/a) - 1) + sec(theta) * sh(x/a));

[~, Index] = min(abs(L - L_sum));

x_test(time_test) = x(Index);
y_test(time_test) = y(Index);

plot(x, y);

xlabel('����ê��ˮƽ����/m')
ylabel('����ê����ֱ����/m')
axis([0 17.15 0 12.5])
set(gca, 'XTick', [0: 18]);
set(gca, 'YTick', [0: 13]);
grid off
