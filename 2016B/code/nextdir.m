function [nextroad,nextdistance,nextstate]=nextdir(cari,RoadMap,Car,Roaddistance,Outroad, RoadCarNum)
% 函数 nextdir 返回 cari 这辆车这一秒之后的状态
% nextroad: 1s后所在的路
% nextdistance:1s后在路上距路入口的逻辑距离
% nextstate: 1s后，该车是否还在区域内
% cari:车的序号
% RoadMap: 路的可达性矩阵
% Car:当前各辆车的状态
% Roaddistance:每条路的长度
% Outroad:所有可能出去的路
% RoadCarNum: 当前每条路上有多少车
car = Car{cari}; %当前正在考虑的车 
nextroad = car.road; 
nextdistance = car.distance;
if car.distance >= Roaddistance(Car{cari}.road) && ismember(car.road,Outroad)
       nextstate = 0;
return; 
else
       nextstate = 1;
end
nextdistance = nextdistance + 1; 
if (Roaddistance(nextroad) < nextdistance)
nextroad = chooseRoad(cari,nextroad,RoadMap,Car,Roaddistance, RoadCarNum); %%%交叉路口选择路的方向
       nextdistance = 1;
% disp(strcat('car', num2str(cari)));
% disp(strcat('change road to', num2str(nextroad)));
   end
   for i = 1 : (cari - 1)
if(Car{i}.state == 1 && Car{i}.road == nextroad && Car{i}.distance == nextdistance)
    %%%% 车辆不能走，
nextroad = car.road; 
nextdistance = car.distance;
end
   end

