j = 1;
L = zeros(2001, 1);
L_test = zeros(2001, 1);

for x_value = 0 : 0.01 : 20

    % L Ϊê������
    L(j) = a*(tan(theta) * (ch(x_value/a) - 1) + sec(theta) * sh(x_value/a));

    % ����ê�����ȹ�ʽ
    for i = 1 : size(x, 2) - 1
        L_test(j) = L_test(j) + sqrt(step^2 + (y(i+1) - y(i))^2);
    end
    
    j = j + 1;
end
