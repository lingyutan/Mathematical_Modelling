
clc
disp('======================================================================================');
disp('                   《基于LOGIT的STOCH配流法??改进的dial算法》');
disp('运行环境：MATLAB 8.3.0.532 ');
disp('制 作 人：兰州交通大学   刘志祥');
disp('Q      Q:531548824');
fprintf('说    明：本程序用于进行静态配流，在经典Dial算法的基础上进行修改，重新定义了有效路径，使得在用\n户的容忍绕路范围内比原来多走h倍路（一般情况下0<h<1,针对路段T(i,j))，即最多不超过2倍的路程，若\nh=0则等同经典算法.dial算法分四大步骤：一是求最短路，二是求边权似然数，三是求路权，四是配流\n');
disp('======================================================================================');
disp('按任意键继续...');
pause;

%数据获取，人机交互
disp('    ***请按照提示输入以下参数***');
Q=input('总 需 求 量:');
thita=input('参 数 thita:');
h=input('容忍绕路倍数:');
r=input('起       点:');
s=input('终       点:');
n=size(T,1);

%初始化
L=zeros(n,n);
W=zeros(n,n);
X=zeros(n,n);

%求最短距离矩阵及最短路径
disp('step1->：求最短距离,其中');
disp('---------------------------------------------------------------------------------------');
disp('   R?起点r到其他点的最短距离');
disp('   S?其他点到终点s的最短距离');
disp('按任意键继续...');
pause;
for i=1:n
    for j=1:n
        if T(i,j)==inf
            T(i,j)=0;
        end
    end
end
T=sparse(T);
Tmin=graphallshortestpaths(T);
[dist,path]=graphshortestpath(T,r,s);
disp('________________________________________________________________');
R=Tmin(r,:)
S=Tmin(:,s)'%注意因为方向性，这里作转置处理
disp('________________________________________________________________');


%画出初始图及最短路,边权为阻抗值t
disp('初始图及最短路径(红色）如图所示:');
chushitu=view(biograph(T,[],'showW','ON'));
set(chushitu.Nodes(path),'Color',[1 0 0]);
edges=getedgesbynodeid(chushitu,get(chushitu.Nodes(path),'ID'));
set(edges,'Linecolor',[1 0 0]);
disp('最短路径：');
path
disp('最短路距离：');
dist

%找上游节点和下游节点（显然up和down互为转置??对称，因为若j是i的下游节点，则i必是j的上游节点）
for i=1:n
    for j=1:n
        if T(i,j)>0
            down(i,j)=1;
            up(j,i)=1;
        else
            down(i,j)=0;
            up(j,i)=0;
        end
    end
end
down=sparse(down);
up=sparse(up);

%计算边权
disp('step2->：计算边权似然值(任意键继续）');
disp('---------------------------------------------------------------------------------------');
pause;
for i=1:n
    for j=1:n
        if down(i,j)
            if R(i)+T(i,j)-R(j)<(1+h)*T(i,j)&&S(j)+T(i,j)-S(i)<(1+h)*T(i,j)
                P=1;
            else
                P=0;
            end
            L(i,j)=P*exp(thita*(R(j)-R(i)-T(i,j)));
        end
    end
end
L=sparse(L)
disp('边权如图所示：');
bianquantu=view(biograph(L,[],'showW','ON'));

%计算路权
disp('step3->：计算路权(任意键继续）');
disp('---------------------------------------------------------------------------------------');
pause;
for i=1:n
    for j=1:n
        if down(i,j)~=0
            if R(i)+T(i,j)-R(j)<(1+h)*T(i,j)&&S(j)+T(i,j)-S(i)<(1+h)*T(i,j)
                if i==r
                    W(i,j)=L(i,j);
                else
                    W(i,j)=L(i,j)*(up(i,:)*W(:,i));
                    %这是核心句,先找到上游节点，再写出上游节点到i的W值（若还没有，则递归直到能够算出）,请仔细查阅路权的算法好好理解。
                end
            end
        end
    end
end
W=sparse(W)
disp('路权如图所示：');
luquantu=view(biograph(W,[],'showW','ON'));

%配流
disp('step4->：配流(任意键继续）');
disp('------------------------------------------------------------------------------------------');
pause;
for i=n:-1:1
    for j=n:-1:1
        if down(i,j)==1
            if R(i)+T(i,j)-R(j)<(1+h)*T(i,j)&&S(j)+T(i,j)-S(i)<(1+h)*T(i,j)
                if j==s
                    X(i,j)=Q*W(i,j)/((up(j,:)*W(:,j)));
                else
                    X(i,j)=X(j,:)*down(j,:)'*W(i,j)/(up(j,:)*W(:,j));
                    %注意X（j,:)是1*n行向量，down(j,:)是1*n行向量,因此要将down向量转置为1*n的列向量才能相乘。
                end
            end
        end
    end
end
X=sparse(X)
disp('配流结果如图所示：');
peiliutu=view(biograph(X,[],'showW','ON'));
disp('======================================================================================');
disp('<程序运行完毕>');  