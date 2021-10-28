M = csvread('data.csv', 1, 1); %��ȡ����ȥ����������
Mstd = corrcoef(M); %���ϵ������
eigval = eig(Mstd); %����ֵ
[eigvec, ~] = eig(Mstd); %��������
m = [eigval, eigvec]; %�ϲ� ��������
mchange = sortrows(m, -1); %����
eigvalsum = sum(eigval); %��������ֵ֮���Լ��㹱����

tempsum = 0; %��Ҫ������ʼ��ֵ
num = 0;

for i = 1 : length(eigval)
    num = num + 1; %���ɷ���Ŀ
    tempsum = tempsum + mchange(i, 1);
    if tempsum / eigvalsum >= 0.85 %�����ʴ� 85%
        break;
    end
end

[mchanger, mchangec] = size(mchange);
coefmartix = mchange(1 : num, 2 : mchangec) %���ɷ�ϵ������