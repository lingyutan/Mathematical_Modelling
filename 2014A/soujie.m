clc,clear all;
%tic
global F;
% 推力
% 力的角度
global beta;
global mu;
global c;
mu=4.903737416799999e+12;
c=2940;
vf=zeros(401,360); 
li = 7500;
F=li;
for ja=1:3600
% ja = 0;
beta=pi/180*ja*0.1;
[t,x]=ode45(@func,[0 :1 :400], [1753000;0 ;0;1692 /1753000;2400] );
h=x(:,1)-1738000;
[n,m]=size(h);
for i=1:n
% 月球引力常数 % 比冲
% 月球引力常数 % 比冲
% 力的角度
% vf(i,ja)=sqrt((x(i,4)*(h(i)+1737000))^2+x(i,2)^2);
% if h(i)>2900 & h(i)<3100
% if vf(i,ja)>47 & vf(i,ja)<67 
%     ja
% end
% end
end
end

% end
% toc %
% figure,plot(t,h);title('h');
% figure,plot(t,x(:,2));title('v');
% figure,plot(t,x(:,3));title('cta');
% figure,plot(t,x(:,4));title('omg');
% figure,plot(t,x(:,5));title('m');