M = csvread('data.csv', 1, 1); %读取数据去掉首行首列
Mstd = corrcoef(M); %相关系数矩阵
eigval = eig(Mstd); %特征值
[eigvec, ~] = eig(Mstd); %特征向量
m = [eigval, eigvec]; %合并 便于排序
mchange = sortrows(m, -1); %排序
eigvalsum = sum(eigval); %计算特征值之和以计算贡献率

tempsum = 0; %必要参数初始赋值
num = 0;

for i = 1 : length(eigval)
    num = num + 1; %主成分数目
    tempsum = tempsum + mchange(i, 1);
    if tempsum / eigvalsum >= 0.85 %贡献率达 85%
        break;
    end
end

[mchanger, mchangec] = size(mchange);
coefmartix = mchange(1 : num, 2 : mchangec) %主成分系数矩阵