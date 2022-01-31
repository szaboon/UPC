close all; clc; clear

I = imread("mask.jpg");

size(I)
%%
[I2, rect] = imcrop(I,[4 3 2 2]);
imshow(I2)
imwrite(I2,'mask.jpg')


