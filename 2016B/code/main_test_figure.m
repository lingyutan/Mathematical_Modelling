
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
legend('С��·��100', 'С��·��200', 'С��·��400', 'С��·��600', 'С��·��800');
xlabel('ʱ��/s');
ylabel('�ۻ���ʱ/s');