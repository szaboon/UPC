
% main file 
close all
clear, clc

% read Template image
% im1=imread('K.JPG');
% im1=imread('S.jpg');
im1=imread('image2.jpg');


% read Traget Image
% im2=imread('letters.JPG');
im2=imread('image1.jpg');

% apply templete matching using power of the image
result=tmp(im1,im2);
x = result(1);
y = result(2);
X = result(3);
Y = result(4);


figure,
subplot(2,2,1),imshow(im1);title('Template');
subplot(2,2,2),imshow(im2);title('Target');
subplot(2,2,3),imshow(im2);title('Matching Result using tmp');
hold on
plot([y y Y Y y],[x X X x x],'r')
hold off
% 
% 
% % apply templete matching using DC components of the image
% result2=tmc(im1,im2);
% 
% figure,
% subplot(2,2,1),imshow(im1);title('Template');
% subplot(2,2,2),imshow(im2);title('Target');
% subplot(2,2,3),imshow(result1);title('Matching Result using tmp');
% subplot(2,2,4),imshow(result2);title('Matching Result using tmc');