p = imread('image1.tif');
[y,x]=size(p);
pp=double(p);
[X,Y]=meshgrid(1:x,1:y);
mesh(pp);% »­Í¼
colormap gray;