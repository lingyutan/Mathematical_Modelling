clc;
clear;

Tmax = 500; %考虑的时间的上限
carnum = 0; %carnum 是当前通过的车的总数目
fieldCarNum = 0; %fieldCarNum 进入小区的车辆数
beta = 0.5; %出现车的概率,体现车流量
fieldCapure = 800; %小区内道路的承载量 
fieldDistance = 100; %小区内道路的逻辑长度

fRpb = 0.8; %行人自行车修正系数 
R = 0.8; %主路右转车进入小区的比例
L1 = 5; %车身长度,km 
h = 25; %标准饱和车头时距
alpha = pi / 4; %转弯角度 
miu = 0.18; %横向力系数
v = 60/3.6; %车辆速度

t_avg = L1 / v ; %畅通情况下车辆直行通过计算截面的平均耗时

ER = (L1 + alpha * R)/(h * sqrt(127 * R * miu)); %右转车转换系数 
fR = 100/(100 + R * (ER - 1)); %右转修正系数

theta = 0; %车辆入口延时的影响因子
delay = zeros(Tmax, 1); %记录入口延时
T = 20; %路灯周期
Tg = 10; %绿灯时间

Car = cell(carnum,1); %Car 是所有的车的集合
Car0 = cell(carnum,1); %Car 是所有的车的集合
car = struct('road',0,'distance',0,'state',0); 
%road 是当前车所在的道路 distance 表示在这条路上的位置 state 表示是否在区域里 1-在里面 0-在外面
t = 0; %当前时间
Dt = cell(t,1); %每个时刻的平均延误
Dt0 = cell(t,1); %每个时刻的平均延误
Light = 0; % Light 表示当前灯是红灯 0，还是绿灯 1

roadnum = 4; %roadnum 是所有的道路数目 
Outroad = []; % 与出口相连的路
Outroad(1) = 4;
Inroad = [2,3]; %与入口相连的路
FieldRoad = []; %小区内的路 
FieldRoad(1) = 3;

 
Troad = zeros(roadnum,1);%每条路上的路灯周期
Troad(:) = 20;

Tgroad = zeros(roadnum,1);%每条路上绿灯时间
Tgroad(:) = 5;

RoadMap = zeros(roadnum,roadnum); %路的可达性矩阵
RoadMap0 = zeros(roadnum,roadnum); %路的可达性矩阵 

Roadcapture = zeros(roadnum,1); %Roadcapture 路的设计承载量 

Roadcarnum = zeros(roadnum,1); %Roadcarnum 路当前有的车数量 
Roadcarnum0 = zeros(roadnum,1); %Roadcarnum 路当前有的车数量 
Roaddistance = zeros(roadnum,1);%Roaddistance 路的距离 
Roaddt = zeros(roadnum,1); %Roaddt 每条路上的平均延迟时间

Roadcapture = [1000,1000,1000,1]; 
Roadcapture(3) = fieldCapure; 
Roadcapture = Roadcapture'; 
Roaddistance = [100,100,100,1]; 
Roaddistance(3) = fieldDistance;


RoadMap = [0,0,0,0;
           1,0,0,0;
           1,0,0,0;
           0,1,1,0]; 
       
RoadMap0 = [0,0,0,0;
            1,0,0,0;
            0,0,0,0;
            0,1,0,0];

myres = zeros(500,4);
Flag = [0,1,0,0]';
mainflow = 3600 * beta; %主路的车流量

for t = 1:Tmax
    %%%%%%判断当前是否有车到来 0 没有，1 有 
    Dt{t} = 0;
    Dt0{t} = 0;
    ra = rand();
    if ra >= beta
        ra = 0;
    else
        ra = 1;
    end

    %%%%%%增加车的数量,更新车的情况 
    if ra == 1
        carnum = carnum+1;
        car.road = 1;
        car.distance = Roaddistance(1);
        car.state = 1;
        Car{carnum} = car;
        Car0{carnum} = car;
        Roadcarnum(1) = Roadcarnum(1)+1; Roadcarnum0(1) = Roadcarnum0(1)+1;
    end
    %%%%%%判断当前红绿灯情况 
    Light = mod(t,T);
    if Light <= Tg
        Light = 1;
    else
        Light = 0;
    end

    for cari = 1:carnum
        
       if(Car{cari}.state == 0)
          continue;
       end

        %%不考虑小区开放时
        if Light == 1 %%%绿灯时
            [nextroad,nextdistance,nextstate] = nextdir(cari,RoadMap0,Car0,Roaddistance,Outroad,Roadcarnum0); 
            %%%函数 nextdir 返回 cari 这辆车下一次所在的路的在路上的距离
        else %%%%红灯时 
            [nextroad,nextdistance,nextstate] = nextdir_red(cari,RoadMap0,Car0,Roaddistance,Outroad,Roadcarnum0);
        end

        Roadcarnum0(Car0{cari}.road) = Roadcarnum0(Car0{cari}.road)-1; 
        Car0{cari}.road = nextroad;
        Car0{cari}.distance = nextdistance;
        Car0{cari}.state = nextstate;
        
        if nextstate == 1
            Roadcarnum0(nextroad) = Roadcarnum0(nextroad)+1; %%%%%%当前这条路上的车的数量
        end

        %%考虑小区开放时
        % disp(strcat('car', num2str(cari)));
        
        if Light == 1 %%%绿灯时 
            [nextroad,nextdistance,nextstate] = nextdir(cari,RoadMap,Car,Roaddistance,Outroad,Roadcarnum); 
            %%%函数 nextdir 返回 cari 这辆车下一次所在的路的在路上的距离
        else %%%%红灯时
            [nextroad,nextdistance,nextstate] = nextdir_red(cari,RoadMap,Car,Roaddistance,Outroad,Roadcarnum);
        end
        
        myres(t, 1) = nextroad;
        myres(t, 2) = nextdistance;
        myres(t, 3) = nextstate;
        myres(t, 4) = cari;
        Roadcarnum(Car{cari}.road) = Roadcarnum(Car{cari}.road)-1; 
        Car{cari}.road = nextroad;
        Car{cari}.distance = nextdistance; 
        Car{cari}.state = nextstate;
        
        if nextstate == 1
            Roadcarnum(nextroad) = Roadcarnum(nextroad)+1; %%%%%%当前这条路上的车的数量
        end
    end
    
    if( ra == 1 && ismember(nextroad, FieldRoad) )
          fieldCarNum = fieldCarNum + 1;
          theta = theta + 1;
    else
        if(theta >= 0.3)
          theta = theta - 0.3;
    else
    theta = 0;
         end
    end

    if(carnum > 0)
        R = R * 0.5 + 0.5 * fieldCarNum / carnum;
        ER = (L1 + alpha * R)/(h * sqrt(127 * R * miu));%右转车转换系数
        fR = 100/(100 + R * (ER - 1));%右转修正系数
        x = (mainflow) / Roadcapture(1); %道路饱和度
        C1 = x * (fRpb + fR); %主流向通行能力
        NDT = (1/C1 - t_avg) * (1/t_avg + 1) * t_avg / 2; %信号交叉路口平均延误
        Dt{t} = theta * NDT;
        delay(t) = Dt{t};
    end
    
    %%%%%%计算每条路的平均延误时间
    dt = ((0.5*Troad).*(1-Tgroad./Troad))./(1-min(1,Roadcarnum.*(720./Roaddistance')./Roadcapture).*(Tgroad./Troad)).*Flag;
       Dt{t} = sum(dt);

    dt0 = ((0.5*Troad).*(1-Tgroad./Troad))./(1-min(1,Roadcarnum0.*(720./Roaddistance')./Roadcapture).*(Tgroad./Troad)).*Flag;
       Dt0{t} = sum(dt0);
end

Dt_Mat = cell2mat(Dt) - 7.5;
Dt_Sum = zeros(1, Tmax);
Dt_Sum(1) = Dt_Mat(1);

for i = 2 : Tmax
    Dt_Sum(i) = Dt_Sum(i - 1) + Dt_Mat(i);
end

Dt0_Mat = cell2mat(Dt0) - 7.5;
Dt0_Sum = zeros(1, Tmax);
Dt0_Sum(1) = Dt0_Mat(1);

for i = 2 : Tmax
    Dt0_Sum(i) = Dt0_Sum(i - 1) + Dt0_Mat(i);
end

dtDelta = cell2mat(Dt0) - cell2mat(Dt); 

% save(strcat(num2str(fieldDistance), 'dtDelta.mat'), 'dtDelta'); 
 save('type1_Dt.mat', 'Dt_Sum'); 
% save(strcat(num2str(beta), 'Dt0.mat'), 'Dt0');
