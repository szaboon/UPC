
close all
clear, clc

% Read Search image
Search_img = imread('letters.JPG');

% Read Template image
Template = imread('S.JPG');

% Getting x & y coordinates of the bounding box
% result = my_xcorr(Search_img,Template);
result = my_SAD(Search_img,Template)

x = result(1);
y = result(2);
X = result(3);
Y = result(4);

% Displaying results
subplot(2,2,1),imshow(Search_img);title('Search image');
subplot(2,2,2),imshow(Template);title('Template');
subplot(2,2,3),imshow(Search_img);title('Matching Result using cross correlation');
hold on
plot([y y Y Y y],[x X X x x],'r')   % Drawing bounding box
hold off
