% �˳�������ģ��ê����״����

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
theta = 0;
step = 0.001;
xmax = 20; %20

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

[~, Index] = min(abs(y - h_c));

% temp_x ê�����ں����ϲ��ֵ�ˮƽ����
temp_x = step * (Index - 1);

% L Ϊê������
L = a*(tan(theta) * (ch(temp_x/a) - 1) + sec(theta) * sh(temp_x/a));

% % ����ê�����ȹ�ʽ
% L_test = 0;
% for i = 1 : size(x, 2) - 1
%     L_test = L_test + sqrt(step^2 + (y(i+1) - y(i))^2);
% end

x_begin = x + L_sum - L;
plot(x + x_begin(1), y);
x_end = temp_x + x_begin(1);
axis([0 x_end 0 13])
title('');
xlabel('����ê��ˮƽ����/m')
ylabel('����ê����ֱ����/m')
set(gca, 'XTick', [0: 15]);
set(gca, 'YTick', [0: 13]);

