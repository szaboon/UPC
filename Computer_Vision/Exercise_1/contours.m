I = imread('images\Figure_Bottles.png');
I = im2gray(I);
bin_I = I<250;
% figure, imshow(bin_I)

se1 = strel('disk', 4,0);
erod_I = imerode(bin_I, se1);
% figure, imshow(erod_I)
% figure, imshowpair(bin_I, erod_I)
bound_I = bin_I-erod_I;
figure, imshow(bound_I)
bin_I2 = imfill(bin_I,'holes');
figure, imshow(bin_I2)
erod_I = imerode(bin_I2, se1);
bound_I2 = bin_I2-erod_I;
figure, imshow(bound_I2)
blobMeasurements = regionprops(bound_I2, 'Perimeter')