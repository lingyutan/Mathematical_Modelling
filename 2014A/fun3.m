function f = fun3(t, x)
g = 1.6249;
ve = 2940;

global F;
global alpha1

f = zeros(3, 1);
f(1) = -F*cos(alpha)/x(3);
f(2) = g - F*sin(alpha)/x(3);
f(3) = F/ve;
end