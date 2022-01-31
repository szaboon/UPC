close all; clc; clear


I = imread('text.tif');
f = imbinarize(I,"global");
% figure
% subplot(1,2,1), imshow(I), title('Original')
% subplot(1,2,2), imshow(f), title('Binarized')

%% Mask 1
mask_W1 = [1 0;1 1;0 1;0 1;1 1;1 0];
match_W1 = imerode(f,mask_W1);

% Mask for highlighting the results
f_mask = [1 1 1 1;
          1 0 0 1;
          1 0 0 1;
          1 0 0 1;
          1 0 0 1;
          1 0 0 1;
          1 0 0 1;
          1 1 1 1];

f_mask_e = [1 1;
            1 1;
            1 1;
            1 1;
            1 1;
            1 1];

match_W_res = imfill(imdilate(match_W1,f_mask),'holes');
match_W_res_e = imdilate(match_W1,f_mask_e);
match = match_W_res-match_W_res_e;
result_a = cat(3,f+match,f-match,f-match);
% result_a = cat(3,f+match_W1,f-match_W1,f-match_W1);
% figure
% subplot(1,2,1), imshow(match_W1), title('Erosion')
% subplot(1,2,2), imshow(result_a), title('Higlights')


%% Mask 2
mask_W2 = [1 1;1 0;1 0;1 0;1 0;1 1];
match_W2 = imerode(f,mask_W2);

% Highlighting
match_W_res = imfill(imdilate(match_W2,f_mask),'holes');
match_W_res_e = imdilate(match_W2,f_mask_e);
match = match_W_res-match_W_res_e;
result_a = cat(3,f+match,f-match,f-match);

% figure
% subplot(1,2,1), imshow(match_W2), title('Erosion')
% subplot(1,2,2), imshow(result_a), title('Higlights')

%% Black and White
% mask_B1 = ~mask_W1;
% figure, imshow(mask_B1)
% figure, imshow(~f)
% match_B1 = imdilate(~f,mask_B1)-~f;
% figure, imshow(match_B1)
% match_WB1 = and(match_W1,match_B1);

mask_B2 = ~mask_W2;
figure, imshow(mask_B2)
figure, imshow(~f)
match_B2 = imerode(~f,mask_B2)-(~f);
figure, imshow(match_B2)
match_WB2 = and(match_W2,match_B2);
figure, imshow(match_WB2)

match_WB_res = imfill(imdilate(match_WB2,f_mask),'holes');
match_WB_res_e = imdilate(match_WB2,f_mask_e);
match = match_WB_res-match_WB_res_e;
result_b = cat(3,f+match,f-match,f-match);
figure
subplot(1,2,1), imshow(match_B2), title('Erosion')
subplot(1,2,2), imshow(result_b), title('Higlights')



match_WB2 = bwhitmiss(f,mask_W2,~mask_W2);
match_WB_res = imfill(imdilate(match_WB2,f_mask),'holes');
% figure, imshow(match_WB_res)
match_WB_res_e = imdilate(match_WB2,f_mask_e);
match = match_WB_res-match_WB_res_e;
result_b = cat(3,f+match,f-match,f-match);
figure
subplot(1,2,1), imshow(match_WB2), title('Erosion')
subplot(1,2,2), imshow(result_b), title('Higlights')