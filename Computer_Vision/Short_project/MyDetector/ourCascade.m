% calcHaarVal() defines white and black area for each haar feature

function val = ourCascade(II, haarSize, i, j)
% II: integral image of an input image
% haarSize: size of the haar feature
% i,j: pixelY/X: start point in (Y,X)
% haarX/Y: Haar feature size in X and Y directions

% getCorners() finds the total of the pixel intensity values 
% in a white and black area

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cascade 1: applying fisrt haar feature from Viola-Jones article
deltaX = floor(haarSize*5); 
deltaY = floor(haarSize*7);     % ⬛⬛⬛
pixelX = j+deltaX;              % ⬜⬜⬜
pixelY = i+deltaY;
haarX = floor(haarSize*14);
haarY = floor(haarSize*8);

black = getCorners(II, pixelX, pixelY, pixelX+haarX ,pixelY+haarY/2);
white = getCorners(II, pixelX, pixelY+haarY/2, pixelX+haarX ,pixelY+haarY);
val1 = white-black;
val1 = val1/(haarX*haarY);

% thresholding
if val1<0
    val = 0;
else
    val = val1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cascade 2: applying second haar feature from Viola-Jones article
if val~=0
    deltaX = floor(haarSize*6);       % ⬛⬜⬛
    deltaY = floor(haarSize*4);       % ⬛⬜⬛
    pixelX = j+deltaX;   % 7
    pixelY = i+deltaY;   % 4
    haarX = floor(haarSize*12); % 12
    haarY = floor(haarSize*5);  % 5
    
    bigBlack = getCorners(II, pixelX, pixelY, pixelX+haarX ,pixelY+haarY);
    white = getCorners(II, pixelX+haarX/3, pixelY, pixelX+haarX*(2/3), pixelY+haarY);
    black = bigBlack-white;
    val2 = white-black;
    val2 = val2/(haarX*haarY);

    % thresholding
    if val2<0
        val2 = 0;
    else
        val2;
    end
    val=val*val2;
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Cascade 3: applying additional haar features that we found working
if val~=0
    % Feature 1: left eye
    deltaX = floor(haarSize*5); 
    deltaY = floor(haarSize*7);     % ⬛
    pixelX = j+deltaX;              % ⬜
    pixelY = i+deltaY;
    haarX = floor(haarSize*5);
    haarY = floor(haarSize*8);
    
    black = getCorners(II, pixelX, pixelY, pixelX+haarX ,pixelY+haarY/2);
    white = getCorners(II, pixelX, pixelY+haarY/2, pixelX+haarX ,pixelY+haarY);
    val3 = white-black;
    val3 = val3/(haarX*haarY);
    
    % Feature 2: right eye
    deltaX = floor(haarSize*13); 
    deltaY = floor(haarSize*7);     % ⬛
    pixelX = j+deltaX;              % ⬜
    pixelY = i+deltaY;
    haarX = floor(haarSize*5);
    haarY = floor(haarSize*8);
    
    black = getCorners(II, pixelX, pixelY, pixelX+haarX ,pixelY+haarY/2);
    white = getCorners(II, pixelX, pixelY+haarY/2, pixelX+haarX ,pixelY+haarY);
    val4 = white-black;
    val4 = val4/(haarX*haarY);
    
    % Feature 5: mouth
    deltaX = floor(haarSize*8); 
    deltaY = floor(haarSize*18);     % ⬛⬛⬛
    pixelX = j+deltaX;               % ⬜⬜⬜
    pixelY = i+deltaY;
    haarX = floor(haarSize*8);
    haarY = floor(haarSize*4);
    
    white = getCorners(II, pixelX, pixelY, pixelX+haarX ,pixelY+haarY/2);
    black = getCorners(II, pixelX, pixelY+haarY/2, pixelX+haarX ,pixelY+haarY);
    val5 = white-black;
    val5 = val5/(haarX*haarY);
    
    % thresholding
    if val3<0 || val4<0 || val5<0
        val = 0;
    else
        val = val*val3*val4*val5;
    end
end



