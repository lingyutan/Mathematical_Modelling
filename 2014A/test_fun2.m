clear, clc;

t_sum = 450; % 最大总用时
vx0 = 1692.53; % 水平初速度
v0 = 0; % 竖直初速度
r0 = 1749373; % 初始高度
omega = vx0 / r0; % 初始角速度
m0 = 2400; % 初始质量
theta = 0; % 初始转动角度

global temp_fai; % 定义全局变量‘临时fai值’

Antibody_Num = 20; % 定义抗体数
Iter_Max = 100; % 定义最大迭代数
H_eps = 2000000;
V_eps = 20;
flag = 0;

for sub = 1 : 3600
    temp_fai = pi/1800*sub;
    [t, A] = ode45(@fun2, [0: 1 :t_sum], [r0 v0 theta omega m0]);

    for i = 1 : t_sum + 1
        v_sum(i, sub) = sqrt(A(i, 2)^2 + (A(i, 4)*A(i, 1))^2);
        H(i, sub) = A(i, 1) - 1737013;
        theta_sum(i, sub) = A(i, 3);
        m_sum(i, sub) = A(i, 5);
    end
end

    sub = 127;
    temp_fai = pi/1800*sub;
    [t, A_M] = ode45(@fun2, [0: 1 :t_sum], [r0 v0 theta omega m0]);

min(min(v_sum))