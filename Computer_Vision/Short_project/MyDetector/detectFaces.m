clc, clear, close all;

% Trying on one image
% I = imread('images2/2.jpg');
% gaussian = fspecial('gaussian',3,1);
% I = imfilter(I,gaussian);
% Ig = im2gray(I);
% Is{1} = Ig;
% IIs{1} = integralImage(Ig);
% images = 1;

% Loading our image database
images = 23;

fprintf('Process: Loading images.\n\n')
% Initializing databases
Is = cell(1,images);
IIs = cell(1,images);
for img = 1:images
    image_path = ['images\',int2str(img),'.jpg'];
    I = imread(image_path);
    Ig = im2gray(I);
    % Filtering image
    gaussian = fspecial('gaussian',5,1);
    Ig = imfilter(Ig,gaussian);
    % Creating image database
    Is{img} = Ig;   % Gray scale images
    II = integralImage(Ig); % Calculating Integral image
    IIs{img} = II;  % Integral images
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
    I_features = {};    % We create a new DB for features for every img
    [row,col] = size(Is{img});    % Size of the image
    maxsize = floor(min([row/24,col/24]));  % Max size for haar feature
    hsize = 0;      % We initialize haar size 
    window = [];    % window is our haar feature size
    for haarSize = 1:0.5:maxsize % Every iteration we make window larger by 0.5
        hsize = hsize+1;    % Counting window changes
        window(hsize) = floor(haarSize*start_haar); % Changing window size
        % Initialize matrix for calculated haar values
        fval = zeros(row-window(hsize)+1,col-window(hsize)+1);
        for i = 1:row-window(hsize)+1       % +1 pixel because we
            for j = 1:col-window(hsize)+1   % substracted it
                fval(i,j) = ourCascade(IIs{img}, haarSize, i, j);
            end
        end
        % Saving feature matrix for each size of the haar feature
        I_features{hsize} = fval;
    end
    
    % Finding the best macth
    bestmatch = []; % Inicialization
    % For every size of the feature we find the highest value
    for f=1:length(I_features)
        bestmatch(f) = max(max(I_features{f})); % Save the highest value
        if bestmatch(f)==0  % if there is no match
            i(f)=0; % We set the coordinates to 0 just to fill matrix
            j(f)=0;
        else    % We save the original coordinates of the highest value 
            [i(f),j(f)] = find(I_features{f}==bestmatch(f));
        end
    end
    % Finding the best from all sizes of the window
    best = max(bestmatch);
    p = find(bestmatch==best);
    p = p(1); % if there is multiple best findings

    % Croping the detected window from the image if we find the face
    if i(p)==0 && j(p)==0
        fprintf(strcat('Info: Could not find a face in image:',int2str(img),'\n'))
    else
        crop = imcrop(Is{img},[j(p),i(p),window(p),window(p)]);
        folder = ['C:\1. Škola\1.semester(ERASMUS)\CV\Short_project\MyDetector\cropedFaces\'];
        fname = fullfile(folder, ['crop' num2str(img) '.jpg']);
        imwrite(crop,fname);
%         imwrite(crop,Filename, "jpg")
        % Plotting results with map, image with bounding box and croped image
%         figure
%         subplot(2,2,1), imshow(I_features{p},[]), hold on
%         subplot(2,2,1), plot(j(p),i(p),'r*'), hold off
%         subplot(2,2,3), imshow(Is{img})
%         subplot(2,2,3), rectangle('Position',[j(p),i(p),window(p),window(p)],'EdgeColor','r')
%         subplot(2,2,4), imshow(crop)

        % Plotting only image and bounding box
%         subplot(1,3,img), imshow(Is{img})
%         subplot(1,3,img), rectangle('Position',[j(p),i(p),window(p),window(p)],'EdgeColor','r')
        
        % Plotting all croped images 
        subplot(4,6,img), imshow(crop)
    end
end



