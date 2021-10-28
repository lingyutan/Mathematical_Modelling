function len = func3(AM, f, N)
  len = AM(f(N), f(1));
  for i = 1 : (N-1)
      len = len + AM(f(i), f(i+1));
  end
  end