
load('100Dt.mat');
Dt_100 = Dt_Sum;

load('200Dt.mat');
% load('200Dt0.mat');
% load('200dtDelta.mat');

Dt_200 = Dt_Sum;
% Dt0_200 = cell2mat(Dt0);
% DtDelta_200 = dtDelta;

load('400Dt.mat');
Dt_400 = Dt_Sum;


load('600Dt.mat');
Dt_600 = Dt_Sum;


load('800Dt.mat');
Dt_800 = Dt_Sum;


x=1:500;
plot(x, Dt_100, x, Dt_200,x, Dt_400,x, Dt_600,x, Dt_800, 'LineWidth', 2);
legend('小区路长100', '小区路长200', '小区路长400', '小区路长600', '小区路长800');
xlabel('时间/s');
ylabel('累积延时/s');