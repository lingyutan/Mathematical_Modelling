load('type1_Dt.mat');
type1_Dt = Dt_Sum;

load('type2_Dt.mat');
type2_Dt = Dt_Sum;

plot(test_x, type1_Dt, 'r', test_x, type2_Dt, 'b', 'LineWidth', 2);
xlabel('ʱ��/s');
ylabel('�����ۻ�����ʱ��Dt/s');
legend('1��С��', '2��С��');
