i=imread('image1.tif');

if(size(i,3)>1)

i=rgb2gray(i);

end

i=double(i);

mesh(flipdim(i,1));