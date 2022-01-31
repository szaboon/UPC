%% Practice 4
close all; clc; clear

I = imread("images\chess.jpg");
I = rgb2gray(I);
sigma = 5;

sobelx = [-1 0 1;-2 0 2;-1 0 1];
sobely = [-1 -2 -1;0 0 0;1 2 1];

Ix = imfilter(I,sobelx);
Iy = imfilter(I,sobely);

Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;

Image = cat(3,Ix2,Iy2,Ixy);
% subplot(2,2,1), imshow(Image)

mask = fspecial('gaussian',sigma);
Ix2g = imfilter(Ix2,mask);
Ixyg = imfilter(Ixy,mask);
Iy2g = imfilter(Iy2,mask);

Trace = Ix2g+Iy2g;
Det = Ix2g.*Iy2g-Ixyg.^2;

k = 0.15;
Mc = Det-k.*Trace.^2;

% Filtering Mc to one pixel
mask1 = [-1 0 1];
Mc1 = imfilter(Mc,mask1);
mask2 = [-1;0;1];
Mc2 = imfilter(Mc1,mask2);
mask3 = [-1 0 1];
Mc3 = imfilter(Mc2,mask3);
mask4 = [-1;0;1];
Mc4 = imfilter(Mc3,mask4);

[x,y] = find(Mc4);

figure, imshow(I), hold on,
plot(x(:)+3,y(:)+3,'r*'), hold off   % Drawing bounding box of CC
title("My Corner Detection")
