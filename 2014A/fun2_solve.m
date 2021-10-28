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
Iter_Max = 10; % 定义最大迭代数
H_eps = inf;
V_eps = 2;
flag = 0;
Clone_Num = 10; % 克隆抗体数
Iter_Num = 0; % 当前克隆次数

fai_Antibody = zeros(Antibody_Num, 4);

%%%%%随机生成满足条件的初始抗体群%%%%%
for i = 1 : Antibody_Num
    while true
        temp_fai = rand(1, 'double')*2-1;
        [t, temp_Mat] = ode45(@fun2, [0: 1 :t_sum], [r0 v0 theta omega m0]);
        temp_H = temp_Mat(:, 1) - 1737013;
        temp_V = sqrt(temp_Mat(:, 2).^2 + (temp_Mat(:, 1).*temp_Mat(:, 4)).^2);
        
        if find(abs(temp_V + -57) < V_eps)
            fai_Antibody(i, 1) = temp_fai;
            fai_Antibody(i, 2) = temp_Mat(find(abs(temp_V + -57) < V_eps, 1, 'first'), 5);
            fai_Antibody(i, 3) = abs(temp_V(find(abs(temp_V + -57) < V_eps, 1, 'first')) + -57);
            break;
        end
    end
end

%%%%%进行免疫处理%%%%%

fai_Antibody_sorted = sortrows(fai_Antibody, [-2, 3]); % 排序

while Iter_Num < Iter_Max
    
    % 选取亲和度前一半的抗体进行免疫处理
    for i = 1 : Antibody_Num/2
        % 进行抗体克隆
        Antibody_Clone = repmat(fai_Antibody_sorted(i, 1), Clone_Num, 1);
        
        % 进行抗体变异
        for j = 2 : Clone_Num
            Antibody_Clone(j) = Antibody_Clone(j) + randn(1)*0.01;
        end
        
        for j = 1 : Clone_Num
            temp_fai = Antibody_Clone(j);
            
            [t, temp_Mat] = ode45(@fun2, [0: 1 :t_sum], [r0 v0 theta omega m0]);
            temp_H = temp_Mat(:, 1) - 1737013;
            temp_V = sqrt(temp_Mat(:, 2).^2 + (temp_Mat(:, 1).*temp_Mat(:, 4)).^2);
            
            if find(abs(temp_V + -57) < V_eps)
                Antibody_Clone(i, 2) = temp_Mat(find(abs(temp_V + -57) < V_eps, 1, 'first'), 5);
                Antibody_Clone(i, 3) = abs(temp_V(find(abs(temp_V + -57) < V_eps, 1, 'first')) + -57);
                Antibody_Clone(i, 4) = 1;
            else
                Antibody_Clone(i, 2) = 0;
                Antibody_Clone(i, 3) = inf;
                Antibody_Clone(i, 4) = 0;
            end
        end
        
        Antibody_Clone_sorted = sortrows(Antibody_Clone, [-4, -2, 3]);
        
        temp_Antibody = zeros(Antibody_Num/2, 4);
        temp_Antibody(i, :) = Antibody_Clone_sorted(1, :);
    end
    
    fai_Antibody(1 : Antibody_Num/2, :) = temp_Antibody(1 : Antibody_Num/2, :);
    
    for i = Antibody_Num/2 + 1 : Antibody_Num
        while true
            temp_fai = rand(1, 'double')*2-1;
            [t, temp_Mat] = ode45(@fun2, [0: 1 :t_sum], [r0 v0 theta omega m0]);
            temp_H = temp_Mat(:, 1) - 1737013;
            temp_V = sqrt(temp_Mat(:, 2).^2 + (temp_Mat(:, 1).*temp_Mat(:, 4)).^2);

            if find(abs(temp_V + -57) < V_eps)
                fai_Antibody(i, 1) = temp_fai;
                fai_Antibody(i, 2) = temp_Mat(find(abs(temp_V + -57) < V_eps, 1, 'first'), 5);
                fai_Antibody(i, 3) = abs(temp_V(find(abs(temp_V + -57) < V_eps, 1, 'first')) + -57);
                break;
            end
        end
    end
    
    fai_Antibody_sorted = sortrows(fai_Antibody, [-4, -2, 3]); % 排序
     
    Iter_Num = Iter_Num + 1;
    
end

Best_fai = fai_Antibody_sorted(1, 1);
[t, Mat] = ode45(@fun2, [0: 1 :t_sum], [r0 v0 theta omega m0]);

%v_sum = zeros(t_sum, 3600);



% for sub = 1 : 3600
%     fai = pi/1800*sub;
%     [t, A] = ode45(@fun2, [0: 1 :t_sum], [r0 v0 theta omega m0]);
% 
%     for i = 1 : t_sum + 1
%         v_sum(i, sub) = sqrt(A(i, 2)^2 + (A(i, 4)*A(i, 1))^2);
%         H(i, sub) = A(i, 1) - 1737013;
%         theta_sum(i, sub) = A(i, 3);
%         m_sum(i, sub) = A(i, 5);
%     end
% end
% 
% plot(t, H(:,1))
% 
% min(min(v_sum))
