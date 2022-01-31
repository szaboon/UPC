% calcHaarVal() defines white and black area for each haar feature

function val = calcHaarVal2(II, haarSize, i, j)
% II: integral image of an input image
% haar: which Haar feature (1-5)
% pixelX/Y: start point in (X,Y)
% haarX/Y: Haar feature size in X and Y directions

% getCorners() finds the total of the pixel intensity values 
% in a white and black area

%⬛
%⬜
% if haar == 1 % top/down black/white
    deltaX = floor(haarSize*5);
    deltaY = floor(haarSize*7);
    pixelX = j+deltaX;
    pixelY = i+deltaY;
    haarX = floor(haarSize*14);
    haarY = floor(haarSize*8);

    black = getCorners(II, pixelX, pixelY, pixelX+haarX ,pixelY+haarY/2);
    white = getCorners(II, pixelX, pixelY+haarY/2, pixelX+haarX ,pixelY+haarY);
    val1 = white-black;
    val1 = val1/(haarX*haarY);

    if val1<0
        val1 = 0;
    else
        val1;
    end

%⬛⬜⬛
% elseif haar == 2 % left/mid/right white-black-white
    deltaX = floor(haarSize*6);
    deltaY = floor(haarSize*3);
    pixelX = j+deltaX;   % 7
    pixelY = i+deltaY;   % 4
    haarX = floor(haarSize*12); % 12
    haarY = floor(haarSize*5);  % 5
    
    bigBlack = getCorners(II, pixelX, pixelY, pixelX+haarX ,pixelY+haarY);
    white = getCorners(II, pixelX+haarX/3, pixelY, pixelX+haarX*(2/3), pixelY+haarY);
    black = bigBlack-white;
    val2 = white-black;
    val2 = val2/(haarX*haarY);
    if val2<0
        val2 = 0;
    else
        val2;
    end
% end
    val=val1*val2;


end




