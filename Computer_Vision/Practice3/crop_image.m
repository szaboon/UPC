close all; clc; clear

I = imread("lena.gif");
[I2, rect] = imcrop(I);
imshow(I2)
% imwrite(I2,'person_temp.jpg')


