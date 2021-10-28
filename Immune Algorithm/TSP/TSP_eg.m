%%%TSP
%����Ⱥ�ڸ�����Antibody_Num = 200
%��ԭά��N=31
%����������Iter_Num_Max=1000
%��¡�������ΪClone_Num=10
%�����������еľ������AM

% �����㷨���TSP����

% ��ʼ��
clear all; % ������б���
close all; % ��ͼ
clc;       % ����

City_Location;  % �������굼��
N = size(CL, 1);  % ������Ŀ

AM = zeros(N);  % ��ʼ���ڽӾ���

% �����ڽӾ���
 for i = 1 : N
     for j = 1 : N
         AM(i,j) = sqrt(((CL(i,1)-CL(j,1))^2+...
         (CL(i,2)-CL(j,2))^2));
     end
 end
 
 Antibody_Num = 200; % ����Ⱥ�ڸ�����
 Iter_Num_Max = 1000; % ����������
 f = zeros(N, Antibody_Num); % ���ڴ洢��Ⱥ
 
  for i = 1 : Antibody_Num
     f(:,i) = randperm(N); % ������ɳ�ʼ��Ⱥ
  end
  
  len = zeros(Antibody_Num, 1); % �洢·������
  
  for i = 1 : Antibody_Num
    len(i) = func3(AM, f(:,i), N); % ������ɳ�ʼ��Ⱥ
  end
  
  [Sortlen,Index] = sort(len);
  Sortf = f(:, Index); % ��Ⱥ��������
  Iter_Num = 0; % ���ߴ���
  Clone_Num = 20; % ��¡����
  
  % ����ѭ�� ��ֹ����
  while Iter_Num < Iter_Num_Max
      % ѡ�׺Ͷ�ǰһ��ĸ���������߲���
      for i = 1 : Antibody_Num/2
          temp_f = Sortf(:, i);
          a_clone = repmat(temp_f, 1, Clone_Num); % ��¡����
          
          % ��¡����ı��� ����Ϊ1 ��һ�б�������Դ 
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
          
          % ��¡���� �����׺Ͷ���ߵĸ���
          for j = 1 : Clone_Num
              Len_Afterclone(j) = func3(AM,a_clone(:,j), N);
          end
          
          % ����ϸ����
          [Sortlen_afterclone, Index] = sort(Len_Afterclone);
          SortCa = a_clone(:, Index);
          af(:, i) = SortCa(:, 1);
          alen(i) = Sortlen_afterclone(1);
      end
      
      % �����¿���
      for i = 1 : Antibody_Num / 2
          bf(:, i) = randperm(N); %������ɳ�ʼ��Ⱥ
          blen(i) = func3(AM, bf(:, i), N); %����·������
      end
      
      % �ϲ�����ϸ������¿���
      f = [af, bf];
      len = [alen, blen];
      [Sortlen, Index]=sort(len);
      Sortf = f(:, Index);
      Iter_Num = Iter_Num + 1; 
      trace(Iter_Num) = Sortlen(1); % ����ÿ�ε������Ž�
  end
  
%   ����Ż����
  Bestf = Sortf(:, 1);   %����·��
  Bestlen = trace(end);  %����·��
  
%   ͼ1
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
  title(['�Ż���̾���:', num2str(trace(end))]);
  
%   ͼ2
  figure 
  plot(trace)
  xlabel('��������')
  ylabel('Ŀ�꺯��ֵ')
  title('�׺ͶȽ�������')
  