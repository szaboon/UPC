% I = [0 0 0 0 0 0 0 0 0 0 0;
%      0 1 1 1 1 0 0 1 1 1 0;
%      0 1 1 1 1 1 1 1 1 1 0;
%      0 1 1 1 1 1 1 1 1 1 0;
%      0 1 1 1 1 0 0 1 1 1 0;
%      0 0 0 0 0 0 0 0 0 0 0];
% 
% mask = [0 1 0;
%         1 1 1;
%         0 1 0];
% E = imerode(I,mask);
% D = imdilate(I,mask);
% figure, imshow(E);
% figure, imshow(D);
close all; clear, clc

A = [0, 0, 0,70,70,70, 0, 0,70,70, 0, 0;
     0, 0, 0,70,70,70, 0, 0,70,70, 0, 0;
     0, 0, 0,70,70,70, 0, 0,70,70, 0, 0;
     0, 0,50,20,20,20,50, 0, 0, 0, 0, 0;
     0,50,20,20,20,40,20,50, 0, 0, 0, 0;
     0,50,20,20,40,20,20,50, 0, 0, 0, 0;
     0,50,20,40,20,20,20,50, 0, 0, 0, 0;
     0,50,40,20,20,20,20,50, 0, 0, 0, 0;
     0, 0,50,20,20,20,50, 0, 0, 0, 0, 0;
     0,50,20,20,20,20,20,50, 0, 0, 0, 0;
     0,50,50,50,50,50,50,50, 0, 0, 0, 0];


I = [0,0,1,1,1,1,0,0,0,0,0,0;
     0,0,1,0,0,1,0,0,0,0,0,0;
     0,1,1,0,0,1,0,0,0,0,0,0;
     0,1,0,0,0,0,1,0,0,0,0,0;
     1,1,0,0,0,0,1,1,0,0,0,0;
     1,0,0,0,0,0,0,1,0,0,0,0;
     1,1,0,0,0,0,1,1,0,0,0,0;
     0,1,0,0,0,0,1,0,0,0,0,0;
     0,1,0,0,0,0,1,0,0,0,0,0;
     0,1,1,0,0,1,1,0,0,0,0,0;
     0,0,1,1,1,1,0,0,0,0,0,0];

imshowpair(A,I)
% figure, imshow(A)
% imhist(A)
A_med = medfilt2(A);
% figure, imshow(A_med)
bin_A = imbinarize(A); % All pixels lower than threshold are 1

mask1 = strel('disk',3,0);

mask2 = [0 1 1 0;
         1 1 1 1;
         1 1 1 1;
         1 1 1 1;
         0 1 1 0];

mask3 = [1;1];


mask4 = [0 0 1;
         0 0 0;
         0 0 0];

mask5 = [0 1 0;
         0 0 0;
         0 0 0];

mask6 = [1;
         1;
         1;
         1;
         1];
         
mask7 =[0,0,1,1,1,1,0,0,0,0,0,0;
        0,0,1,0,0,1,0,0,0,0,0,0;
        0,1,1,0,0,1,0,0,0,0,0,0;
        0,1,0,0,0,0,1,0,0,0,0,0;
        1,1,0,0,0,0,1,1,0,0,0,0;
        1,0,0,0,0,0,0,1,0,0,0,0;
        1,1,0,0,0,0,1,1,0,0,0,0;
        0,1,0,0,0,0,1,0,0,0,0,0;
        0,1,0,0,0,0,1,0,0,0,0,0;
        0,1,1,0,0,1,1,0,0,0,0,0;
        0,0,1,1,1,1,0,0,0,0,0,0];

mask8 = ones(3);

mask9 = strel('disk',4,0);
mask10 = [1 1 1;
          1 1 1;
          1 1 1];
mask11 = A_med;


% M1 = imerode(bin_A,mask11);
M1 = imerode(bin_A,bin_A);
M2 = imdilate(M1,mask7);
M3 = imdilate(M2,mask4);
M4 = imdilate(M3,mask5);
M5 = imdilate(M4,mask7);
M6 = imdilate(M5,mask4);
M7 = imdilate(M6,mask7);
M8 = imerode(M7,mask10);
M9 = imdilate(M8,mask1);
M10 = imdilate(M9,mask1);
M11 = imdilate(M10,mask1);
M12 = imdilate(M11,mask1);
figure
subplot(4,3,1), imshow(A), title('Original')
subplot(4,3,2), imshow(I), title('Finall')
subplot(4,3,3), imshow(bin_A), title('mid')
subplot(4,3,4), imshow(M1), title('1')
subplot(4,3,5), imshow(M2), title('2')
subplot(4,3,6), imshow(M3), title('3')
subplot(4,3,7), imshow(M4), title('4')
subplot(4,3,8), imshow(M5), title('5')
subplot(4,3,9), imshow(M6), title('6')
subplot(4,3,10), imshow(M7), title('7')
subplot(4,3,11), imshow(M8), title('8')
subplot(4,3,12), imshow(M9), title('9')
% subplot(4,3,10), imshow(M10), title('10')
% subplot(4,3,11), imshow(M11), title('11')
% subplot(4,3,12), imshow(M12), title('12')


% %%
% % Reset Workspace
% clear all
% close all
% clc
% 
% % set constants
% BinaryThreshold = 250;
% r = 2; % thickness of the Boundary
% n = 0;
% 
% % load Image
% I = imread("images\Figure_Bottles.png");
% IGray = rgb2gray(I);
% figure, imshow(I)
% IBin = IGray < BinaryThreshold;
% imshow(IBin)
% 
% se2 = strel('disk', 3);
% IBinNoise = imerode (IBin, se2);
% IBinNoise = imdilate(IBinNoise, se2);
% figure, imshow(IBinNoise)
% 
% 
% 
% IFilled = imfill(IBinNoise,'holes');
% figure, imshow(IFilled)
% 
% % remove shadows
% se3 = strel('disk', 15);
% IFilled = imerode (IFilled, se3);
% IFilled = imdilate(IFilled, se3);
% figure, imshow(IFilled)
% 
% 
% se = strel('disk', r,n);
% IErosion = imerode(IFilled, se);
% figure, imshow(IErosion)
% % imshowpair(IBin, IErosion)
% % imshowpair(IBin, IErosion, 'montage')
% Boundaries = IFilled - IErosion;
% imshow(Boundaries)
% 
% 
% figure, imshowpair(I, 1-Boundaries)
