%=========================主程序部分================================ 
function isodata(X,K,theta_N,theta_S0,theta_C0,L0,I) 
%输入样本X，每一列为一个样本 
%输入预期的聚类数目K 
%输入每一聚类样本域的最小数目theta_N 
%输入同一聚类域中样本距离分布的标准差theta_S 
%输入两个聚类中心的最小距离theta_C 
%输入一次迭代运算中可以合并的聚类中心的最多对数L 
%输入迭代运算的次数I 
 
global n N Nc z w theta_S theta_C L 
theta_S=theta_S0; 
theta_C=theta_C0; 
L=L0; 
[n,N]=size(X); 
Nc=K; 
z=X(:,1:Nc); 
w=zeros(1,N);    %w存储每一个元素的类别 
iteration=1;        %循环次数控制 
 
flag=1; 
while flag==1 
        for i=1:N 
                w(i)=classification(z,X(:,i)); 
        end 
         
        %判断是否需取消某些类 
        i=1; 
        while i<=Nc 
                di=find(w==i); 
                if length(di)
                        z_temp=z; 
                        z(:,i)=[]; 
                        for j=1:length(di) 
                                w(di(j))=classification(z,z_temp(:,di(j))); 
                        end 
                        Nc=Nc-1; 
                        i=i-1; 
                end 
                i=i+1; 
        end 
         
        %更新分类中心的值 
        for i=1:Nc 
                di=find(w==i); 
                z(:,i)=sum(X(:,di),2)/length(di); 
        end 
         
        disp(z); 
         
        %求类平均和总平均 
        D=zeros(1,Nc);D_mean=0; 
        for i=1:Nc 
                di=find(w==i); 
                for j=1:length(di) 
                        D(i)=D(i)+norm(X(:,di(j))-z(:,i))/length(di); 
                end 
                D_mean=D_mean+length(di)*D(i)/N; 
        end 
         
        %判断分裂，合并或结束 
        if iteration==I 
                return; 
        elseif Nc<=K/2 
                seperate;    
        elseif mod(iteration,2)==0||Nc>2*K 
                consolidation; 
        end 
         
        if iteration==I 
                return; 
        else 
                iteration=iteration+1; 
        end 
         
end 
 
disp(w); 
 
end 
 
%=================================分类函数================================== 
function [c]=classification(Z,x) 
%分类函数：输入类别中心矩阵X和待分类向量 
%返回Z中与x最近的元素的下表 
 
[~,N_C]=size(Z); 
d=zeros(1,N_C); 
                 
for i=1:N_C 
        d(i)=norm(Z(:,i)-x); 
end 
 
fid=find(d==min(d)); 
c=fid(1);          
end 
 

%=================================合并函数================================ 
function consolidation 
 
global Nc z w theta_C L 
 
D=zeros(Nc,Nc);       %聚类中心距离矩阵 
for i=1:Nc 
        for j=1:Nc 
                D(i,j)=norm(z(:,i)-z(:,j)); 
        end 
end 
 
%对聚类中心的距离按从小到大顺序排序，存放于IX 矩阵中 
%前两行存放指标，最后一行存放相应的D值 
IX=zeros(3,Nc*(Nc-1)); 
k=1; 
for j=1:Nc 
        I=1:Nc; 
        I(j)=[]; 
        for i=I 
                IX(1,k)=i; 
                IX(2,k)=j;       
                IX(3,k)=D(i,j); 
                k=k+1;                
        end 
end 
 
[~,id]=sort(IX(3,:)); 
IX_sort=zeros(3,Nc*(Nc-1)); 
for i=1:Nc*(Nc-1) 
        IX_sort(:,i)=IX(:,id(i)); 
end 
 
for i=1:L 
        if IX_sort(3,i)
                di=find(w==IX_sort(1,i)); 
                dj=dinf(w==IX_sort(2,i)); 
                l_di=length(di); 
                l_dj=length(dj); 
                z(:,di)=(l_di*z(:,IX_sort(1,i))+l_dj*z(:,IX_sort(2,i)))/(l_di+l_dj); 
                z(:,dj)=[]; 
        end 
end              
end

%=============================分裂函数==================================== 
function seperate 
 
global n Nc z w theta_S  
 
sigma=zeros(n,Nc); 
for j=1:Nc 
        fid=find(w==j); 
        for i=1:n 
                sigma(i,j)=sqrt((X(i,fid)-z(i,j)).^2/length(fid)); 
        end 
                 
        jmax=find(sigma(:,j)==max(sigma(:,j))); 
        sigma_jmax=sigma(jmax,j); 
        if sigma_jmax>theta_S && ((D(i)>D_mean&&length(fid)>2*(theta_N+1))||Nc<=K/2) 
              z(jmax,j)=z(jmax,j)+0.5*sigma_jmax; 
              z_minus=z(:,j); 
              z_minus(jmax)=z_minus(jmax)-0.5*sigma_jmax; 
              z=[z,z_minus]; 
        end 
end 
end 
