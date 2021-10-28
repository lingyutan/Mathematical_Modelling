function f = fun1(t, x)
G = 6.67259e-11;
M = 7.3477e+22;
F = 7500;
ve = 2940;
theta = pi/180*6; % µ÷Õû
f(1) = x(2);
f(2) = -G*M/(x(1)^2+x(3)^2)*sin(atan(x(1)/x(3)))+(-cos(theta)*x(2)-sin(theta)*x(4));
f(3) = x(4);
f(4) = (G*M/(x(1)^2+x(3)^2)*cos(atan(x(1)/x(3)))-(sin(theta)*x(2)-cos(theta)*x(4)));
f(5) = -F/ve;
f = f';
end
