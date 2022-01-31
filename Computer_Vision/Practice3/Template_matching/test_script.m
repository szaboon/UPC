close all; clc; clear
% A = [ 1  2  3 -4  5
%       6  7 -8  9 10
%      11 12 13 14 15
%      16 17 18 19 20
%      21 22 23 24 25];
% 
% B = [1 2
%      3 4];
% 
% [r1,c1] = size(A);
% [r2,c2] = size(B);
% % abs(A)
% % mean(mean(A))
% C_col = im2col(uint8(A),[r2 c2], 'sliding');
% B_col = B(:);
% % ones(size(C)).*mean(C)
% % C
% C_col_mean = C_col-uint8(ones(size(C_col)).*mean(C_col))
% B_size_C = uint8(ones(size(C_col)).*B_col)
% 
% corr = sum(C_col_mean.*B_size_C)
% corrMat = col2im(corr,[1 1],[r1-1 c1-1])
% 
% [r,c]=max(corrMat);
% [r3,c3]=max(max(corrMat));
% 
% i=c(c3);    % Number of row with max. correlation
% j=c3;   
% 
% x = i;
% y = j;
% X = i+r2-1;
% Y = j+c2-1;
% result = [x,y,X,Y]

I = imread("images/toys.png");
% img = im2gray(img);
[I2, rect] = imcrop(I);
imshow(I2)
imwrite(I2,'toys_apple.jpg')
% size(img)

%car
% x = 1510;
% X = 1740;
% y = 1040;
% Y = 1300;

% x = 1;
% X = 160;
% y = 250;
% Y = 490;
% 
% szx = x:X;
% szy = y:Y;
% 
% [r,g,b] = imsplit(img);
% img = cat(3,r,g,b);
% red = r(szy,szx);
% green = g(szy,szx);
% blue = b(szy,szx);
% 
% Image = cat(3,red, blue, green);
% 
% 
% subplot(1,2,1), imshow(img)
% subplot(1,2,2), imshow(Image)
% 
% 
% 
