%%%TSP
%抗体群内个体数Antibody_Num = 200
%抗原维数N=31
%最大迭代次数Iter_Num_Max=1000
%克隆个体个数为Clone_Num=10
%任意两个城市的距离矩阵AM

% 免疫算法解决TSP问题

% 初始化
clear all; % 清除所有变量
close all; % 清图
clc;       % 清屏

City_Location;  % 城市坐标导入
N = size(CL, 1);  % 城市数目

AM = zeros(N);  % 初始化邻接矩阵

% 计算邻接矩阵
 for i = 1 : N
     for j = 1 : N
         AM(i,j) = sqrt(((CL(i,1)-CL(j,1))^2+...
         (CL(i,2)-CL(j,2))^2));
     end
 end
 
 Antibody_Num = 200; % 抗体群内个体数
 Iter_Num_Max = 1000; % 最大迭代次数
 f = zeros(N, Antibody_Num); % 用于存储种群
 
  for i = 1 : Antibody_Num
     f(:,i) = randperm(N); % 随机生成初始种群
  end
  
  len = zeros(Antibody_Num, 1); % 存储路径长度
  
  for i = 1 : Antibody_Num
    len(i) = func3(AM, f(:,i), N); % 随机生成初始种群
  end
  
  [Sortlen,Index] = sort(len);
  Sortf = f(:, Index); % 种群个体排序
  Iter_Num = 0; % 免疫代数
  Clone_Num = 20; % 克隆个数
  
  % 免疫循环 终止条件
  while Iter_Num < Iter_Num_Max
      % 选亲和度前一半的个体进行免疫操作
      for i = 1 : Antibody_Num/2
          temp_f = Sortf(:, i);
          a_clone = repmat(temp_f, 1, Clone_Num); % 克隆抗体
          
          % 克隆抗体的变异 概率为1 第一列保留抗体源 
          for j = 2 : Clone_Num
              p1 = randi(N);
              p2 = randi(N);
              while p1 == p2
                  p2 = randi(N);
              end
              
              temp = a_clone(p1, j);
              a_clone(p1, j) = a_clone(p2, j);
              a_clone(p2, j) = temp;
          end
          
          % 克隆抑制 保留亲和度最高的个体
          for j = 1 : Clone_Num
              Len_Afterclone(j) = func3(AM,a_clone(:,j), N);
          end
          
          % 记忆细胞库
          [Sortlen_afterclone, Index] = sort(Len_Afterclone);
          SortCa = a_clone(:, Index);
          af(:, i) = SortCa(:, 1);
          alen(i) = Sortlen_afterclone(1);
      end
      
      % 生成新抗体
      for i = 1 : Antibody_Num / 2
          bf(:, i) = randperm(N); %随机生成初始种群
          blen(i) = func3(AM, bf(:, i), N); %计算路径长度
      end
      
      % 合并记忆细胞库和新抗体
      f = [af, bf];
      len = [alen, blen];
      [Sortlen, Index]=sort(len);
      Sortf = f(:, Index);
      Iter_Num = Iter_Num + 1; 
      trace(Iter_Num) = Sortlen(1); % 储存每次迭代最优解
  end
  
%   输出优化结果
  Bestf = Sortf(:, 1);   %最优路径
  Bestlen = trace(end);  %最优路长
  
%   图1
  figure 

  for i = 1 : N-1
      plot([CL(Bestf(i), 1),CL(Bestf(i+1), 1)],...
           [CL(Bestf(i), 2),CL(Bestf(i+1), 2)],'o-');
      hold on;
  end
  
  plot([CL(Bestf(N),1),CL(Bestf(1),1)],...
       [CL(Bestf(N),2),CL(Bestf(1),2)],'o:');
  hold on;
  
  for k = 1 : N
      text(CL(k, 1), CL(k, 2), num2str(CL(k, 3)), 'fontweight', 'bold');
  end
  title(['优化最短距离:', num2str(trace(end))]);
  
%   图2
  figure 
  plot(trace)
  xlabel('迭代次数')
  ylabel('目标函数值')
  title('亲和度进化曲线')
  