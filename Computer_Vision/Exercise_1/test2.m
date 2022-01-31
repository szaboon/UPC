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

% imshowpair(A,I)
% figure, imshow(A)
% imhist(A)
A_med = medfilt2(A);
% figure, imshow(A_med)
bin_A = imbinarize(A_med); % All pixels lower than threshold are 1

mask1 = strel('disk',1,0)

mask2 = [0 1 1 0;
         1 1 1 1;
         1 1 1 1;
         1 1 1 1;
         0 1 1 0];

mask3 = [1;1];


mask4 = [0 0 0;
         0 0 1;
         0 0 0];

mask5 = [0 1 0;
         0 0 0;
         0 0 0];

mask6 = [0 1;
         0 1;
         0 1;
         0 1];
         
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
mask10 = [0 0 0;
          0 1 0;
          0 1 0];
mask11 = [0 1 0;
          0 1 0;
          0 0 0];


M1 = imerode(bin_A,mask1);
M2 = imdilate(M1,mask5);
M3 = imerode(M2,mask10);
M4 = imdilate(M3,mask11);
M5 = imerode(M4,mask3);
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