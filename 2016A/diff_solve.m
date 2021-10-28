% syms x a theta;
% y = a * (sec(theta)*(cosh(x/a) - 1) + tan(theta)*sinh(x/a));
% diff(y)

syms x;
diff(sh(x))