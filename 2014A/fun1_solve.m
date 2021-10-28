% clear;
% clc;
t_sum = 450;
vx0 = 1692.53;
vy0 = 0;
x0 = 0;
y0 = 1749372;
m0 = 2400;
H_end = 1737372;

[t, A] = ode45(@fun1, [0: 1 :t_sum], [x0 vx0 y0 vy0 m0]);

L_eps = zeros(size(A, 1), 1);

for i = 1 : size(A, 1)
    L_eps(i) = abs(sqrt(A(i, 1)^2 + A(i, 3)^2) - H_end);
    
end

