% �˳�������ģ������ϵ��ϵͳ
% ���ӹ���:������Ѱ����theta

% temp_F1 ÿһ���ֹ��ܵ������ϵ���
% temp_F2 ÿһ���ֹ��ܵ������µ���
% alpha[] ÿһ���ֹ��ܵ������ϵ�����ֱ����ļн�
% beta[] ÿһ���ֹ�����ֱ�������б�н�

clear, clc;

v = 12; % ����
m_b = 100; % ��Ͱ������
m_f = 1000; % ���������
m_t = 10; % �ֹ�����
m_r = 1200 - 156.4885; % ���������� ��ȥ����
h_sum = 18; % ��ˮ�ܸ߶�

rho = 1.025e+3; % ��ˮ���ܶ�
g = 9.80665; % �����׼�������ٶ�

theta = 0;
% %%%% ��ʼ���� %%%%
% theta = 0; 

h1_theta; % ���ݱ�������thetaֵ�����ˮ���h1

F_f = rho * g * pi * h1;
R = 0.625 * 2 * h2 * v^2;

temp_F1 = sqrt((F_f - m_f * g)^2 + R^2); % ��һ���ֹ��ܵ������ϵ���
alpha(1) = atan(R / (F_f - m_f * g));

% ����������ֹ���ֱ����н�beta
for i = 1 : 4
    
    temp_F2 = sqrt((m_t*g)^2 + temp_F1^2 - 2*m_t*g*temp_F1*cos(alpha(i)));
    alpha(i+1) = acos(-(temp_F2^2 +(m_t*g)^2 - temp_F1^2) / (2*temp_F2*m_t*g));
    
    b = sqrt(temp_F1^2 + (m_t*g/2)^2 - 2*temp_F1*(m_t*g/2)*cos(alpha(i))); % ��ʱֵ
    angle = acos((b^2 + temp_F2^2 - (m_t*g/2)^2) / (2*b*temp_F2));
    beta(i) = alpha(i+1) - angle;
    
    temp_F1 = temp_F2;
end

% F_b �ֹܶԸ�Ͱ���ϵ�����
F_b = temp_F1;
m_b_temp = m_b - rho * pi * 0.15^2;

temp_F2 = sqrt((m_b_temp*g)^2 + temp_F1^2 - 2*m_b_temp*g*temp_F1*cos(alpha(5)));
alpha(6) = acos(-(temp_F2^2 +(m_b_temp*g)^2 - temp_F1^2) / (2*temp_F2*m_b_temp*g));

b = sqrt(temp_F1^2 + (m_b_temp*g/2)^2 - 2*temp_F1*(m_b_temp*g/2)*cos(alpha(5))); % ��ʱֵ
angle = acos((b^2 + temp_F2^2 - (m_b_temp*g/2)^2) / (2*b*temp_F2));
beta(5) = alpha(6) - angle;
    
% ��beta��Ϊ�Ƕ���
beta_angle = beta / pi * 180;

% temp_F ê���Ը�Ͱ���µ�����
temp_F = sqrt((m_r*g)^2 + F_b^2 - 2*(m_r*g)*F_b*cos(alpha(5)));

% temp_angle ê�������ͺ����ļн�
temp_angle = acos((temp_F^2 +F_b^2 - (m_r*g)^2) / (2*F_b*temp_F));

% angle_F ��������ֱ����ļн�
angle_F = alpha(5) + temp_angle;

% ��ֹܸ�Ͱ���ܸ߶�
temp_h_sum = 0;

for i = 1 : 5
    temp_h_sum = temp_h_sum + cos(beta(i));
end

% h_c ê�����ܸ߶�
h_c = h_sum - h1 - temp_h_sum;

% ��ֹܸ�Ͱ����ˮƽ����
temp_r_sum = 0;

for i = 1 : 5
    temp_r_sum = temp_r_sum + sin(beta(i));
end

% R_sum �ζ�����뾶
