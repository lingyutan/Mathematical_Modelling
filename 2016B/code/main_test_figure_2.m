test_x = 1 : 500;
% subplot(1, 2, 1)
% plot(test_x, Dt_Mat,'r', test_x, Dt0_Mat)
% legend('С������', 'С��������');
% xlabel('ʱ��/s');
% ylabel('����ƽ������ʱ��Dt/s')
% % axis([0 500 7 10])
% subplot(1, 2, 2)
% plot(test_x, Dt_Sum, 'r', test_x, Dt0_Sum, 'b');

% legend('С������', 'С��������');
load('type1_Dt.mat');
type1_Dt = Dt_Sum;

load('type2_Dt.mat');
type2_Dt = Dt_Sum;

load('type3_Dt.mat');
type3_Dt = Dt_Sum;

plot(test_x, type1_Dt, 'r', test_x, type2_Dt, 'b', test_x, type3_Dt, 'LineWidth', 2);
xlabel('ʱ��/s');
ylabel('�����ۻ�����ʱ��Dt/s');
legend('1��С��', '2��С��', '3��С��');

Dt_Sum(end)
Dt0_Sum(end)