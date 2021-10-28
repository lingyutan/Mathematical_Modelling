function f = fun2(t, x)
G = 6.67259e-11;
M = 7.3477e+22;
F = 7500;
ve = 2940;

global temp_fai;

f = zeros(5, 1);
f(1) = x(2);
f(2) = F/x(5)*sin(temp_fai)-G*M/(x(1)^2)+x(4)^2*x(1);
f(3) = x(4);
f(4) = -1/x(1)*(F/x(5)*cos(temp_fai)+2*x(2)*x(4));
f(5) = -F/ve;
end