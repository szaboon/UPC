
%% Exercise 3-3
I = imread('moon.tif');
% Applying our geomean function to filter the image with colfilt
I2 = uint8(colfilt(I,[5 5],'sliding',@mygeomean));

% Displaying results
subplot(1,2,1), imshow(I),title('Original Image')
subplot(1,2,2), imshow(I2),title('Filtered Image (mygeomean)')