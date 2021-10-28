clear, clc;

t_sum = 450; % �������ʱ
vx0 = 1692.53; % ˮƽ���ٶ�
v0 = 0; % ��ֱ���ٶ�
r0 = 1749373; % ��ʼ�߶�
omega = vx0 / r0; % ��ʼ���ٶ�
m0 = 2400; % ��ʼ����
theta = 0; % ��ʼת���Ƕ�

global temp_fai; % ����ȫ�ֱ�������ʱfaiֵ��

Antibody_Num = 20; % ���忹����
Iter_Max = 100; % ������������
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