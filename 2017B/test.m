%=========================�����򲿷�================================ 
function isodata(X,K,theta_N,theta_S0,theta_C0,L0,I) 
%��������X��ÿһ��Ϊһ������ 
%����Ԥ�ڵľ�����ĿK 
%����ÿһ�������������С��Ŀtheta_N 
%����ͬһ����������������ֲ��ı�׼��theta_S 
%���������������ĵ���С����theta_C 
%����һ�ε��������п��Ժϲ��ľ������ĵ�������L 
%�����������Ĵ���I 
 
global n N Nc z w theta_S theta_C L 
theta_S=theta_S0; 
theta_C=theta_C0; 
L=L0; 
[n,N]=size(X); 
Nc=K; 
z=X(:,1:Nc); 
w=zeros(1,N);    %w�洢ÿһ��Ԫ�ص���� 
iteration=1;        %ѭ���������� 
 
flag=1; 
while flag==1 
        for i=1:N 
                w(i)=classification(z,X(:,i)); 
        end 
         
        %�ж��Ƿ���ȡ��ĳЩ�� 
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
         
        %���·������ĵ�ֵ 
        for i=1:Nc 
                di=find(w==i); 
                z(:,i)=sum(X(:,di),2)/length(di); 
        end 
         
        disp(z); 
         
        %����ƽ������ƽ�� 
        D=zeros(1,Nc);D_mean=0; 
        for i=1:Nc 
                di=find(w==i); 
                for j=1:length(di) 
                        D(i)=D(i)+norm(X(:,di(j))-z(:,i))/length(di); 
                end 
                D_mean=D_mean+length(di)*D(i)/N; 
        end 
         
        %�жϷ��ѣ��ϲ������ 
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
 
%=================================���ຯ��================================== 
function [c]=classification(Z,x) 
%���ຯ��������������ľ���X�ʹ��������� 
%����Z����x�����Ԫ�ص��±� 
 
[~,N_C]=size(Z); 
d=zeros(1,N_C); 
                 
for i=1:N_C 
        d(i)=norm(Z(:,i)-x); 
end 
 
fid=find(d==min(d)); 
c=fid(1);          
end 
 

%=================================�ϲ�����================================ 
function consolidation 
 
global Nc z w theta_C L 
 
D=zeros(Nc,Nc);       %�������ľ������ 
for i=1:Nc 
        for j=1:Nc 
                D(i,j)=norm(z(:,i)-z(:,j)); 
        end 
end 
 
%�Ծ������ĵľ��밴��С����˳�����򣬴����IX ������ 
%ǰ���д��ָ�꣬���һ�д����Ӧ��Dֵ 
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

%=============================���Ѻ���==================================== 
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
