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
Iter_Max = 10; % ������������
H_eps = inf;
V_eps = 2;
flag = 0;
Clone_Num = 10; % ��¡������
Iter_Num = 0; % ��ǰ��¡����

fai_Antibody = zeros(Antibody_Num, 4);

%%%%%����������������ĳ�ʼ����Ⱥ%%%%%
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

%%%%%�������ߴ���%%%%%

fai_Antibody_sorted = sortrows(fai_Antibody, [-2, 3]); % ����

while Iter_Num < Iter_Max
    
    % ѡȡ�׺Ͷ�ǰһ��Ŀ���������ߴ���
    for i = 1 : Antibody_Num/2
        % ���п����¡
        Antibody_Clone = repmat(fai_Antibody_sorted(i, 1), Clone_Num, 1);
        
        % ���п������
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
    
    fai_Antibody_sorted = sortrows(fai_Antibody, [-4, -2, 3]); % ����
     
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
