
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

% Image = cat(3,Ix2,Iy2,Ixy);
% subplot(2,2,1), imshow(Image)

mask = fspecial('gaussian',sigma);
Ix2g = imfilter(Ix2,mask);
Ixyg = imfilter(Ixy,mask);
Iy2g = imfilter(Iy2,mask);

Trace = Ix2g+Iy2g;
Det = Ix2g.*Iy2g-Ixyg.^2;

k = 0.15;
Mc = Det-k.*Trace.^2;

%%
% Changing image to gray levels
Search_img_gray=Mc;
Template_gray = imread('mask.jpg');

% Sizes of the images
[r1,c1]=size(Search_img_gray);
[r2,c2]=size(Template_gray);

% Subtract the mean value so that there are roughly equal numbers of
% negative and positive values.
Temp_mean=Template_gray-mean(mean(Template_gray));

% Doing cross correlation on every sliding image under mask
corrMat=[];
for i=1:(r1-r2+1)
    for j=1:(c1-c2+1)
        % Sliding mask(Template) on every image and substracting mean
        img_under_mask=Search_img_gray(i:i+r2-1,j:j+c2-1);
        img_under_mask=img_under_mask-mean(mean(img_under_mask));  
        % Calculating sum of cross correlation
        corr=sum(sum(img_under_mask.*Temp_mean));
        corrMat(i,j)=corr;
    end 
end

% Finding maximum correlation
[r,c]=max(corrMat);
[r3,c3]=max(max(corrMat));
k = 0.95;
max(max(corrMat))
SolcorrMat = k*max(max(corrMat))

%%
C = [];
for i=1:size(corrMat,1)
    for j=1:size(corrMat,2)
        if corrMat(i,j)>SolcorrMat
            C = [C;[i,j]]
        end
    end 
end

figure
imshow(I)
hold on, plot(C(:,1),C(:,2),'r*'), hold off   % Drawing bounding box of CC
