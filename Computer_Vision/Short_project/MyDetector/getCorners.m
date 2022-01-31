
% getCorners.m - takes in an integral image and computes the sum of 
% intensities in the area bounded by the four coordinates

function intensity = getCorners(img,startX,startY,endX,endY)

                              %       Integral Image
    a = img(startY,startX);   %    (1,1)__________
    b = img(startY,endX);     %        |__a|______|b
    c = img(endY,startX);     %        |   | area |
    d = img(endY,endX);       %        |___|______|
                              %           c        d

    intensity = d-(b+c)+a; % by property of the integral image

end