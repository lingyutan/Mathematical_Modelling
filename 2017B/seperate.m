clear, clc;

data1 = xlsread('data1.xls');
data2 = xlsread('data2.xlsx');

global Latitude_Min Latitude_Merge_Length;
global Longitude_Min Longitude_Merge_Length;

Matrix_Size = 50;

Latitude_Min = min(data1(:, 1));
Latitude_Max = max(data1(:, 1));
Latitude_Merge_Length = (Latitude_Max - Latitude_Min) / Matrix_Size;

Longitude_Min = min(data1(:, 2));
Longitude_Max = max(data1(:, 2));
Longitude_Merge_Length = (Longitude_Max - Longitude_Min) / Matrix_Size;


Task_Distribution = zeros(Matrix_Size, Matrix_Size);
Task_Distribution = Merge(data1, Matrix_Size);

Member_Distribution = zeros(Matrix_Size, Matrix_Size);
Member_Distribution = Merge(data2, Matrix_Size);

temp = zeros(size(data1, 1), 3);
temp_distance = zeros(4, 1);

% SPSS求得四个聚类中心
Center = zeros(4, 2);
Center = [22.6649404 114.046711;
          23.4229457 113.335487;
          22.9567672 113.745689;
          23.0613687 113.224298];

for i = 1 : size(data1, 1)
    
    Latitude_No = floor((data1(i, 1) - Latitude_Min) / Latitude_Merge_Length) + 1;
    if Latitude_No == Matrix_Size + 1
        Latitude_No = Latitude_No - 1;
    end
    
    Longitude_No = floor((data1(i, 2) - Longitude_Min) / Longitude_Merge_Length) + 1;
    if Longitude_No == Matrix_Size + 1
        Longitude_No = Longitude_No - 1;
    end
    
    temp(i, 1) = Member_Distribution(Latitude_No, Longitude_No);
    temp(i, 2) = Task_Distribution(Latitude_No, Longitude_No);
    
    for j = 1 : 4
        temp_distance(j) = sqrt((data1(i, 1) - Center(j, 1))^2 +...
                           (data1(i, 2) - Center(j, 2))^2);
    end
    temp(i, 3) = min(temp_distance);
end

 

% 画图检验
% p = Member_Distribution;
% [y,x]=size(p);
% [X,Y]=meshgrid(1:x,1:y);
% mesh(p);% 画图
% colormap gray;

