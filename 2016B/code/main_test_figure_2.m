test_x = 1 : 500;
% subplot(1, 2, 1)
% plot(test_x, Dt_Mat,'r', test_x, Dt0_Mat)
% legend('小区开放', '小区不开放');
% xlabel('时间/s');
% ylabel('车辆平均延误时间Dt/s')
% % axis([0 500 7 10])
% subplot(1, 2, 2)
% plot(test_x, Dt_Sum, 'r', test_x, Dt0_Sum, 'b');

% legend('小区开放', '小区不开放');
load('type1_Dt.mat');
type1_Dt = Dt_Sum;

load('type2_Dt.mat');
type2_Dt = Dt_Sum;

load('type3_Dt.mat');
type3_Dt = Dt_Sum;

plot(test_x, type1_Dt, 'r', test_x, type2_Dt, 'b', test_x, type3_Dt, 'LineWidth', 2);
xlabel('时间/s');
ylabel('车辆累积延误时间Dt/s');
legend('1号小区', '2号小区', '3号小区');

Dt_Sum(end)
Dt0_Sum(end)