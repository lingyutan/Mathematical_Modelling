clear all;close all;clc
%定义 button 
plotbutton=uicontrol('style','pushbutton',... 'string','Run',...
'fontsize',12,...
'position',[100,400,50,20],...
'callback','run=1;');

erasebutton=uicontrol('style','pushbutton',...
'string','Stop',...
'fontsize',12,...
'position',[300,400,50,20],...
'callback','freeze=1;');

number=uicontrol('style','text',...
'string','1',...
'fontsize',12,...
'position',[20,400,50,20]);
z=zeros(38,4);
cells=z;%元胞矩阵 
p1=0.4;%变道概率 
p2=0.4;%转弯概率 
t1=0;%时间变量 
t2=0;%时间变量
%初始状态
cells(1,1)=0; 
cells(1,2)=1; 
cells(38,3)=0; 
cells(38,4)=1; 
run=1; 
freeze=0; 
while 1
if run== 0
    %下行
        for j=1:37
            if cells(j,1)==1&&cells(j,2)==0
                if rand()>p1
                    cells(j+1,1)=0;
                    cells(j+1,2)=1;
                else
                    cells(j+1,1)=1;
                    cells(j+1,2)=0;
                end
            end
if cells(j,1)==0&&cells(j,2)==1
        if rand()>p1
            cells(j+1,1)=1;
            cells(j+1,2)=0;
        else
            cells(j+1,1)=0;
            cells(j+1,2)=1;
        end
end
    if cells(j,1)==1&&cells(j,2)==1
        cells(j+1,1)=1;
        cells(j+1,2)=1;
    end
    if cells(j,1)==0&&cells(j,2)==0
        cells(j+1,1)=0;
        cells(j+1,2)=0;
    end
end
%上行
for j=38:-1:2
    if cells(j,3)==1&&cells(j,4)==0
        if rand()>p1
            cells(j-1,3)=0;
            cells(j-1,4)=1;
        else
            cells(j-1,3)=1;
            cells(j-1,4)=0;
        end
    end
    if cells(j,3)==0&&cells(j,4)==1
        if rand()>p1
            cells(j-1,3)=1;
            cells(j-1,4)=0;
        else
            cells(j-1,3)=0;
            cells(j-1,4)=1;
        end
end
    if cells(j,3)==1&&cells(j,4)==1
        cells(j-1,3)=1;
        cells(j-1,4)=1;
    end
               if cells(j,3)==0&&cells(j,4)==0
        cells(j-1,3)=0;
        cells(j-1,4)=0;
    end
end
%显示图像 
[A,B]=size(cells);
Area(1:A,1:B,1)=zeros(A,B);
Area(1:A,1:B,2)=zeros(A,B);
Area(1:A,1:B,3)=zeros(A,B);
for i=1:A
    for j=1:B
        if cells(i,j)==1
            Area(i,j,:)=[255,222,0];
        elseif cells(i,j)==0
            Area(i,j,:)=[0,90,171];
        end
    end
end
            Area=uint8(Area);
            Area=imagesc(Area);
            axis equal;
            axis tight;
%计步 
stepnumber=1+str2num(get(number,'string'));
set(number,'string',num2str(stepnumber));
    end
    if freeze==1
run=0;
       freeze=0;
    end
drawnow 
end