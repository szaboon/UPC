%% Calculating Haar Features
close all; clc, clear

% Number of training samples used
faceImages = 300;
nonFaceImages = 300;

fprintf(strcat('\nProcess: ***Training images inicialization***\n'))
% Loading face images
fprintf('Info: Loading face images.\n')
faceIIs = cell(1,faceImages);
for img = 1:faceImages
    image_path = ['TrainingFaces\',int2str(img),'.pgm'];
    I = imread(image_path);
    II = integralImage(I);
    faceIIs{img} = II;
end

% Loading non-face images
fprintf('Info: Loading non-face images.\n')
nonfaceIIs = cell(1,nonFaceImages);
for img = 1:nonFaceImages
    image_path = ['TrainingNonFaces\',int2str(img),'.pgm'];
    I = imread(image_path);
    II = integralImage(I);
    nonfaceIIs{img} = II;
end

%
% We found database with 19x19 pixel size images, it would be better to use
% 24x24 pixel images because of more compatible feature sizes. In our case
% we dont calculate feature value for last row or column of pixels in with
% certain features
window = 19;    % Training Image size
haarSize = 1;   % Haar feature size multiplier for faster computation
                %  1    2    3    4    5
haars = haarSize*[1,2; 2,1; 1,3; 3,1; 2,2];
first_size =     [3,2; 2,3; 3,3; 3,3; 4,4]; % Small haars are not robust anyways

count = 0; % Feature count
featureDatabase = []; % To store calculated features
classifier = []; % To store Haar type and size

% In this for cycle we calculate feature value of all posible sizes and all
% possible locations of haar feature
fprintf(strcat('\nProcess: ***Calculating Haar feature values started***\n'))
for haar = 1:5 % Calculatig features for all haar types
    fprintf(strcat('Info: Calculating features for Haar:',int2str(haar),'\n'))
    dimX = haars(haar,1);
    dimY = haars(haar,2);
    fsX = first_size(haar,1);
    fsY = first_size(haar,2);
    for pixelY = 1:1:window-dimY+1 % +1 because the Inegral image is one dimension bigger
        for pixelX = 1:1:window-dimX+1
            for haarY = fsY:dimY:window-pixelY+1
                for haarX = fsX:dimX:window-pixelX+1
                    % Counting number of features
                    count = count+1;
                   
                    % Calculating Feature value for face images
                    fvectorF = ones(faceImages,1);
                    for img = 1:faceImages
                        fval = calcHaarVal(faceIIs{img}, haar, pixelX, pixelY, haarX, haarY);
                        fvectorF(img) = fval;
                    end

                    % Calculating Feature value for non-face images
                    fvectorNF = ones(nonFaceImages,1);
                    for img = 1:nonFaceImages
                        fval = calcHaarVal(nonfaceIIs{img}, haar, pixelX, pixelY, haarX, haarY);
                        fvectorNF(img) = fval;
                    end
                    
                    % Creating calculated feature vector and database
                    fvector = [fvectorF;fvectorNF];
                    featureDatabase(:,count) = fvector;
                    % Saving Haar parameters for displayment
                    classifier = [classifier;pixelX,pixelY,haarX,haarY,haar];
                end
            end
        end
    end
    fprintf(strcat('Info: Number of features for Haar:',int2str(haar),' is :',int2str(count),'\n'))
end
fprintf(strcat('\nProcess: ***Calculating Haar feature values ended***\n'))


%% Adaboost
fprintf(strcat('\nProcess: ***Starting Adaboost***\n'))

% Initialization of variables
numFValues = faceImages+nonFaceImages;
initialWeights = ones(numFValues,1)./(numFValues);
initialWeight = 1/(numFValues);
PvectorWeights = ones(faceImages,2);
NvectorWeights = -ones(nonFaceImages,2);
topClassifiers = [];

% Number of adaboost iterations
iterations = 50;
for stemps = 1:iterations
    fprintf(strcat('Info: Iteration:',int2str(stemps),'\n'))
    % For calculated feature values of each haar feature applied on our 
    % training images we are gonna find the best threshold for each haar 
    % feature and then calculate the Gini index. Then we find the lowest
    % Gini index which represents haar feature that could classifi the
    % sample values with least amount of incorrectly classified samples.
    for f = 1:size(featureDatabase,2)
        fvector = [PvectorWeights;NvectorWeights];
        fvector(:,1) = featureDatabase(:,f);
        [~, order] = sort(fvector(:,1));
        fsorted = fvector(order,:);
        avg = zeros(size(fsorted,1),1);
        GiniThreshold = zeros(size(fsorted,1)-1,1);
        
        % Calculating threshold
        for t = 1:size(fsorted,1)-1
            avg(t) = (fsorted(t,1)+fsorted(t+1,1))/2;  % Average between 2 neighbour features
            lower = (fsorted(:,1)<avg(t)).*fsorted;    % Features lower than calculated avg
            higher = (fsorted(:,1)>avg(t)).*fsorted;   % Features higher than calculated avg
            lowP = length(find(lower(:,2)==1));     % False negative features
            lowN = length(find(lower(:,2)==-1));    % True negative features
            highP = length(find(higher(:,2)==1));   % True positive features
            highN = length(find(higher(:,2)==-1));  % False positive features
            GiniThreshold(t) = Gini(lowP,lowN,highP,highN);
        end
        % We find the lowest Gini value which is the number that
        % best separates positive and negative samples
        threshold = avg(GiniThreshold==min(GiniThreshold));
        if length(threshold)>1;threshold = threshold(1);end
        % Separating features using this threshold
        lower = (fsorted(:,1)<threshold).*fsorted;    % Features lower than calculated avg
        higher = (fsorted(:,1)>threshold).*fsorted;   % Features higher than calculated avg
        lowP = length(find(lower(:,2)==1));     % False negative features
        lowN = length(find(lower(:,2)==-1));    % True negative features
        highP = length(find(higher(:,2)==1));   % True positive features
        highN = length(find(higher(:,2)==-1));  % False positive features
        
        GiniError(f,1) = Gini(lowP,lowN,highP,highN);
        GiniError(f,2) = threshold;
    end
    % Saving 10 best classifiers from each iteration
    [~, order] = sort(GiniError(:,1));
    topOrder = order(1:10);
    topClassifiers = [topClassifiers;classifier(topOrder,:),GiniError(topOrder,2)];
    
    % We don't need to calculate new weights if this is the last iteration
    if stemps == iterations
        fprintf(strcat('\nProcess: ***Finished Adaboost***\n'))
        break
    end

    % Minimal Gini value or haar feature that has least number of incorrectly
    % classified samples
    minGiniVal = min(GiniError(:,1)); 
    minGiniPos = find(GiniError(:,1)==minGiniVal); % Position in Database
    minGiniPos = minGiniPos(1); % If there is multiple positions of min value
    threshold = GiniError(minGiniPos,2); % Taking already calculated threshold
    
    % For better memory we calculate it one again and we don't store all
    % calculated values for each feature
    fvector = [PvectorWeights;NvectorWeights];
    fvector(:,1) = featureDatabase(:,minGiniPos(1)); % features of best classifier
    [~, order] = sort(fvector(:,1));
    fsorted = fvector(order,:); % sorted features of best classifier
    
    % Separating features using this threshold
    lower = (fsorted(:,1)<threshold(1)).*fsorted;    % Features lower than calculated avg
    higher = (fsorted(:,1)>threshold(1)).*fsorted;   % Features higher than calculated avg
    lowP = length(find(lower(:,2)==1));     % False negative features
    lowN = length(find(lower(:,2)==-1));    % True negative features
    highP = length(find(higher(:,2)==1));   % True positive features
    highN = length(find(higher(:,2)==-1));  % False positive features
    % Positions of incorrectly classified samples
    incorrectPos = [find(lower(:,2)==1);find(higher(:,2)==-1)];
    
    % Calculating Amount of Say for each weight
    error = initialWeight*(lowP+highN);
    if error==1; error=1.01; end
    AoS = 0.5*log((1-error)/error); % Amount of Say 
    % Weight multiplier
    multiplier = ones(faceImages+nonFaceImages,1);
    multiplier(:,1) = exp(-AoS);
    multiplier(incorrectPos,1) = exp(AoS);
    % New weights
    neweights = initialWeights.*multiplier;
    neweights = neweights/sum(neweights);
    
    % Creating new collection of stamples
    cum = cumsum(neweights);
    newOrder = ones(numFValues,1);
    for w = 1:numFValues
        between = 0;
        rnd = rand;
        wn = 1;
        while between == 0
            if rnd<cum(wn)
                between = 1;
                newOrder(w) = wn;
            else
                wn = wn+1;
            end
        end
    end
    featureDatabase = featureDatabase(newOrder,:);
end

% Saving results
save topClassifiers topClassifiers

%% Displaying our best haar features from every iteration 
load topClassifiers.mat
n=1;
niceClassifiers=[];
for l = 1:50
    niceClassifiers = [niceClassifiers;topClassifiers(n,:)];
    n=l*10+1;
end
dispFeatures(5,10,50,niceClassifiers)

%% Displaying our learning data set

n=0;
figure('Name','Training face images');
for img = 1:60
    n=img*10+1;
    image_path = ['TrainingFaces\',int2str(n),'.pgm'];
    I = imread(image_path);
    subplot(6,10,img), imshow(I)
end

n=0;
figure('Name','Training non-face images');
for img = 1:60
    n=img*10+1;
    image_path = ['TrainingNonFaces\',int2str(n),'.pgm'];
    I = imread(image_path);
    subplot(6,10,img), imshow(I)
end

