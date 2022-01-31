
% calcHaarVal() defines white and black area for each haar feature and
% calculates final feature value

function val = calcHaarVal(II,haar,pixelX,pixelY,haarX,haarY)
% II: integral image of an input image
% haar: which Haar feature (1-5)
% pixelX/Y: start point in (X,Y)
% haarX/Y: Haar feature size in X and Y directions

% getCorners() finds the total of the pixel intensity values 
% in a white and black area

%⬛
%⬜
if haar == 1 % top/down black/white
    black = getCorners(II, pixelX, pixelY, pixelX+haarX, pixelY+haarY/2);
    white = getCorners(II, pixelX, pixelY+haarY/2, pixelX+haarX, pixelY+haarY);
    val = (white-black)/(haarX*haarY);

%⬜⬛
elseif haar == 2 % left/right white-black
    white = getCorners(II, pixelX, pixelY, pixelX+haarX/2, pixelY+haarY);
    black = getCorners(II, pixelX+haarX/2, pixelY, pixelX+haarX, pixelY+haarY);
    val = (white-black)/(haarX*haarY);

%⬛
%⬜
%⬛
elseif haar == 3 % top/mid/bottom black/white/black
    bigBlack = getCorners(II, pixelX, pixelY, pixelX+haarX ,pixelY+haarY);
    white = getCorners(II, pixelX, pixelY+(haarY/3), pixelX+haarX, pixelY+haarY*(2/3));
    black = bigBlack-white;
    val = (white-black)/(haarX*haarY);

%⬛⬜⬛
elseif haar == 4 % left/mid/right black-white-black
    bigBlack = getCorners(II, pixelX, pixelY, pixelX+haarX ,pixelY+haarY);
    white = getCorners(II, pixelX+haarX/3, pixelY, pixelX+haarX*(2/3), pixelY+haarY);
    black = bigBlack-white;
    val = (white-black)/(haarX*haarY);

%⬜⬛
%⬛⬜
elseif haar == 5 % checkerboard-style white-black/black-white
    white1 = getCorners(II,pixelX,pixelY,pixelX+haarX/2,pixelY+haarY/2);
    black1 = getCorners(II,pixelX+haarX/2,pixelY,pixelX+haarX,pixelY+haarY/2);
    black2 = getCorners(II,pixelX,pixelY+haarY/2,pixelX+haarX/2,pixelY+haarY);
    white2 = getCorners(II,pixelX+haarX/2,pixelY+haarY/2,pixelX+haarX,pixelY+haarY);
    val = (white1+white2-(black1+black2))/(haarX*haarY);
end