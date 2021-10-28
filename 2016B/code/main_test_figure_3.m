load('type1_Dt.mat');
type1_Dt = Dt_Sum;

load('type2_Dt.mat');
type2_Dt = Dt_Sum;

plot(test_x, type1_Dt, 'r', test_x, type2_Dt, 'b', 'LineWidth', 2);
xlabel('时间/s');
ylabel('车辆累积延误时间Dt/s');
legend('1号小区', '2号小区');
