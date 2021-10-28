% 此程序用于模拟整个系泊系统
% 附加功能:遍历搜寻最优theta

% temp_F1 每一根钢管受到的向上的力
% temp_F2 每一根钢管受到的向下的力
% alpha[] 每一根钢管受到的向上的力竖直方向的夹角
% beta[] 每一根钢管与竖直方向的倾斜夹角

clear, clc;

v = 12; % 风速
m_b = 100; % 钢桶的质量
m_f = 1000; % 浮标的质量
m_t = 10; % 钢管质量
m_r = 1200 - 156.4885; % 重物球质量 减去浮力
h_sum = 18; % 海水总高度

rho = 1.025e+3; % 海水的密度
g = 9.80665; % 地球标准重力加速度

theta = 0;
% %%%% 开始遍历 %%%%
% theta = 0; 

h1_theta; % 根据遍历到的theta值求出吃水深度h1

F_f = rho * g * pi * h1;
R = 0.625 * 2 * h2 * v^2;

temp_F1 = sqrt((F_f - m_f * g)^2 + R^2); % 第一根钢管受到的向上的力
alpha(1) = atan(R / (F_f - m_f * g));

% 迭代求出各钢管竖直方向夹角beta
for i = 1 : 4
    
    temp_F2 = sqrt((m_t*g)^2 + temp_F1^2 - 2*m_t*g*temp_F1*cos(alpha(i)));
    alpha(i+1) = acos(-(temp_F2^2 +(m_t*g)^2 - temp_F1^2) / (2*temp_F2*m_t*g));
    
    b = sqrt(temp_F1^2 + (m_t*g/2)^2 - 2*temp_F1*(m_t*g/2)*cos(alpha(i))); % 临时值
    angle = acos((b^2 + temp_F2^2 - (m_t*g/2)^2) / (2*b*temp_F2));
    beta(i) = alpha(i+1) - angle;
    
    temp_F1 = temp_F2;
end

% F_b 钢管对钢桶向上的拉力
F_b = temp_F1;
m_b_temp = m_b - rho * pi * 0.15^2;

temp_F2 = sqrt((m_b_temp*g)^2 + temp_F1^2 - 2*m_b_temp*g*temp_F1*cos(alpha(5)));
alpha(6) = acos(-(temp_F2^2 +(m_b_temp*g)^2 - temp_F1^2) / (2*temp_F2*m_b_temp*g));

b = sqrt(temp_F1^2 + (m_b_temp*g/2)^2 - 2*temp_F1*(m_b_temp*g/2)*cos(alpha(5))); % 临时值
angle = acos((b^2 + temp_F2^2 - (m_b_temp*g/2)^2) / (2*b*temp_F2));
beta(5) = alpha(6) - angle;
    
% 把beta化为角度制
beta_angle = beta / pi * 180;

% temp_F 锚链对钢桶向下的拉力
temp_F = sqrt((m_r*g)^2 + F_b^2 - 2*(m_r*g)*F_b*cos(alpha(5)));

% temp_angle 锚链拉力和合力的夹角
temp_angle = acos((temp_F^2 +F_b^2 - (m_r*g)^2) / (2*F_b*temp_F));

% angle_F 拉力和竖直方向的夹角
angle_F = alpha(5) + temp_angle;

% 求钢管钢桶段总高度
temp_h_sum = 0;

for i = 1 : 5
    temp_h_sum = temp_h_sum + cos(beta(i));
end

% h_c 锚链段总高度
h_c = h_sum - h1 - temp_h_sum;

% 求钢管钢桶段总水平距离
temp_r_sum = 0;

for i = 1 : 5
    temp_r_sum = temp_r_sum + sin(beta(i));
end

% R_sum 游动区域半径
