function Sum = fun(vector, num, AM)
Sum = AM(vector(num), vector(1));
for i = 1 : num - 1
    Sum = Sum + AM(vector(i + 1), vector(i));
end
end

