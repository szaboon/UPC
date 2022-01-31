clc, clear, close all;

I = imread('TrainingFaces\21.pgm');

gaussian = fspecial('gaussian',3,1);
I = imfilter(I,gaussian);
Ig = im2gray(I);
% Is{1} = Ig;
% IIs{1} = integralImage(Ig);
% images = 1;
figure
% for i = 1:19
I(18,19) = 0;
I(19,19) = 255;
subplot(4,5,1), imshow(I)
% end

%% GINI
tp=3;
fp=1;
fn=0;
tn=2;
gini1 = 1-(tp/(tp+fp))^2-(fp/(tp+fp))^2
gini2 = 1-(fn/(fn+tn))^2-(tn/(fn+tn))^2
Gini = ((tp+fp)/6)*gini1+((fn+tn)/6)*gini2

%%
% Sum check for haar 1
% I(6:8,8:16)
% black = sum(sum(I(8:11,6:19)))
% white = sum(sum(I(12:15,6:19)))
% white-black
% [II(11,20),II(11,6),II(8,20),II(8,6)]
% IIbblack = II(9,17)-II(9,8)-II(4,17)+II(4,8)
% IIwhite = II(9,14)-II(9,11)-II(4,14)+II(4,11)
% IIblack = IIbblack-IIwhite
% IIval = IIwhite-IIblack

% Sum check for Haar 2
% I(4:8,8:16)
% bigblack = sum(sum(I(4:8,8:19)))
% white = sum(sum(I(4:8,12:15)))
% black=bigblack-white
% white-black
% [II(11,20),II(11,6),II(8,20),II(8,6)]
% IIbblack = II(9,17)-II(9,8)-II(4,17)+II(4,8)
% IIwhite = II(9,14)-II(9,11)-II(4,14)+II(4,11)
% IIblack = IIbblack-IIwhite
% IIval = IIwhite-IIblack


images = 13;

fprintf('Process: Loading images.\n\n')
Is = cell(1,images);
IIs = cell(1,images);
for img = 1:images
    image_path = ['images\',int2str(img),'.jpg'];
    I = imread(image_path);
    Ig = im2gray(I);
    Is{img} = Ig;
    II = integralImage(Ig);
    IIs{img} = II;
end


% Initial size of the haar feature
start_haar = 24;
haarSize = 1;

% Initializing croped faces database
crop = {};
%
% Detection for all images in database
fprintf(strcat('Process: Starting with detection\n'))
for img = 1:images
    fprintf(strcat('Info: Detecting faces on image:',int2str(img),'\n'))
    I_features = {};
    [row,col] = size(Is{1});
    maxsize = floor(min([row/24,col/24]));
    hsize = 0;
    window = [];
    for haarSize = 1:0.5:maxsize
        hsize = hsize+1;
        window(hsize) = floor(haarSize*start_haar);
%         fprintf(strcat('Info: Calculating feature values for Haar:',int2str(row-window(hsize)),'\n'))
        fval = zeros(row-window(hsize)+1,col-window(hsize)+1);
        for i = 1:row-window(hsize)+1 % +1 because the Inegral image is one dimension bigger
            for j = 1:col-window(hsize)+1
                fval(i,j) = ourCascade(IIs{img}, haarSize, i, j);
            end
        end
        I_features{hsize} = fval;
    end
    bestmatch = [];
    p = 0;
    for f=1:length(I_features)
        bestmatch(f) = max(max(I_features{f}));
        if bestmatch(f)==0
            i(f)=0;
            j(f)=0;
        else
            [i(f),j(f)] = find(I_features{f}==bestmatch(f));
        end
    end
    % Finding the best from all sizes of the window
    best = max(bestmatch);
    p = find(bestmatch==best);
    p = p(1); % if there is multiple best findings

    % Croping the detected window from the image
    if i(p)==0 && j(p)==0
        fprintf(strcat('Info: Could not find a face in image:',int2str(img),'\n'))
    else
        crop = imcrop(Is{img},[j(p),i(p),window(p),window(p)]);
        Filename = sprintf('crop%d.jpg',img);
        save(['C:\1. Škola\1.semester(ERASMUS)\CV\Short_project\MyDetector\cropedFaces\' Filename],"crop")

        % Plotting results
        figure
        subplot(2,2,1), imshow(I_features{p},[]), hold on
        subplot(2,2,1), plot(j(p),i(p),'r*'), hold off
        subplot(2,2,3), imshow(Is{img})
        subplot(2,2,3), rectangle('Position',[j(p),i(p),window(p),window(p)],'EdgeColor','r')
        subplot(2,2,4), imshow(crop)
        
%         subplot(2,7,img), imshow(crop)
    end
end

%% Plotting best



