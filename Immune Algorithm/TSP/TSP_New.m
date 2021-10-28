clear all;
clc;

City_Location;

City_Num = size(CL, 1);
Adj_Mat = zeros(City_Num); % 初始化邻接矩阵


% 计算邻接矩阵
for i = 1 : City_Num
    for j = 1 : City_Num
        Adj_Mat(i, j) = sqrt((CL(j, 1) - CL(i, 1))^2 + ...
                             ((CL(j, 2) - CL(i, 2))^2));
    end
end

Antibody_Num = 200; % 抗体数目
City_Num = size(CL, 1); % 城市数目
IterNum = 0; % 迭代次数
IterMax = 100; % 最大迭代次数
trace = zeros(1, IterMax);
 
Antibody = zeros(City_Num, Antibody_Num);

% 随机生成初始抗体群 并计算总距离
for i = 1 : Antibody_Num
    Antibody(:, i) = randperm(City_Num);
end
for i = 1 : Antibody_Num
    Antibody(City_Num+1, i) = fun(Antibody(1:City_Num, i), City_Num, Adj_Mat);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%进行免疫处理%%%%%%%%%%%%%%%%%%%%%%%%%%%

Antibody_sorted = sortrows(Antibody', City_Num + 1)'; % 抗体按总距离排序

Clone_Num = 200; % 抗体克隆数
trace = zeros(1, IterMax);

while IterNum < IterMax
    
    % 选取亲和度前一半的抗体进行免疫处理
    for i = 1 : Antibody_Num/2
        % 进行抗体克隆
        Antibody_Clone = repmat(Antibody_sorted(1 : City_Num, 1), 1, Clone_Num);
        
        %%%%%%%%上一句可能有错！！！！！
        
        % 进行抗体变异
        for j = 2 : Clone_Num
            p1 = randi(City_Num);
            p2 = randi(City_Num);
            
            while p1 == p2
                p2 = randi(City_Num);
            end
            
            % 交换
            temp = Antibody_Clone(p1, j);
            Antibody_Clone(p1, j) = Antibody_Clone(p2, j);
            Antibody_Clone(p2, j) = temp;
        end
        
        % 计算抗体克隆后总距离
        for j = 1 : Clone_Num
            Antibody_Clone(City_Num+1, j) = fun...
                (Antibody_Clone(1 : City_Num, j), City_Num, Adj_Mat);
        end
        
        tempmat = sortrows(Antibody_Clone', City_Num + 1)';
        Antibody_a(:, i) = tempmat(:, 1);
    end
    
    for i = 1 : Antibody_Num/2
        Antibody_b(1 : City_Num, i) = randperm(City_Num);
    end
    
    for i = 1 : Antibody_Num/2
        Antibody_b(City_Num+1, i) = fun(Antibody_b(1:City_Num, i), City_Num, Adj_Mat);
    end
    
    Antibody = [Antibody_a Antibody_b];
    Antibody_sorted = sortrows(Antibody', City_Num + 1)'; % 抗体按总距离排序
    
    IterNum = IterNum + 1;
    trace(IterNum) = Antibody_sorted(City_Num + 1, 1);
    
end

Best_Path = Antibody_sorted(1 : City_Num, 1);
Best_Length = Antibody_sorted(City_Num + 1, 1);

figure(1)

for i = 1 : City_Num
    plot([CL(Best_Path(i), 1),...
          CL(Best_Path((i + 1) - (i == City_Num) * City_Num),1)],...
         [CL(Best_Path(i), 2),...
          CL(Best_Path((i + 1) - (i == City_Num) * City_Num),2)],...
          'o-');
     hold on
end

for k = 1 : City_Num
    text(CL(k, 1), CL(k, 2), num2str(CL(k, 3)), 'fontweight', 'bold');
end
title(['优化最短距离', num2str(trace(end))]);

figure(2)
plot(trace);
xlabel('迭代次数');
ylabel('目标函数值');
title('亲和度进化曲线');
