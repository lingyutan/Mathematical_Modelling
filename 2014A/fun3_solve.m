vx0 = 53.8855;
vy0 = 19.7874;
m0 = 1359.1387;

global F;
global alpha;

F = 3928;
alpha = 
[t, A] = ode45(@fun3, [0: 0.5 : 50], [vx0 vy0 m0]);