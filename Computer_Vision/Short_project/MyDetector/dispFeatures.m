% This function will display how dows a haar feature look like using
% starting pixel X and Y and size of the haar feature in X and Y direction.
function plot = dispFeatures(subR,subC,numHaars,classifier)

% bw=1 - to show black/white haar features with boarders
% bw=0 - to show exact haar features on gray image
bw=1;
window = 19;
figure
for i = 1:numHaars
    pixelX = classifier(i,1);
    pixelY = classifier(i,2);
    haarX = classifier(i,3);
    haarY = classifier(i,4);
    haar = classifier(i,5);
    threshold = classifier(i,6);

%⬛
%⬜
    if haar==1
        if bw==1
            topHaar = zeros(window+2);
            topHaar(2:window+1,2:window+1)=1;
            topHaar(pixelY:pixelY+haarY+1,pixelX:pixelX+haarX+1)=0;
            topHaar(pixelY+haarY/2+1:pixelY+haarY,pixelX+1:pixelX+haarX)=1;
        else
            topHaar = ones(window).*0.5;
            topHaar(pixelY:pixelY+haarY/2-1,pixelX:pixelX+haarX-1)=0;
            topHaar(pixelY+haarY/2:pixelY+haarY-1,pixelX:pixelX+haarX-1)=1;
        end
        subplot(subR,subC,i), imshow(topHaar)
        bestHaar{i} = topHaar;

%⬜⬛
    elseif haar==2
        if bw==1
            topHaar = zeros(window+2);
            topHaar(2:window+1,2:window+1)=1;
            topHaar(pixelY:pixelY+haarY+1,pixelX:pixelX+haarX+1)=0;
            topHaar(pixelY+1:pixelY+haarY,pixelX+1:pixelX+haarX/2)=1;
        else
            topHaar = ones(window).*0.5;
            topHaar(pixelY:pixelY+haarY-1,pixelX:pixelX+haarX/2-1)=0;
            topHaar(pixelY:pixelY+haarY-1,pixelX+haarX/2:pixelX+haarX-1)=1;
        end
%         subplot(subR,subC,i), imshow(topHaar)
%         bestHaar{i} = topHaar;

%⬛
%⬜
%⬛
    elseif haar==3
        if bw==1
            topHaar = zeros(window+2);
            topHaar(2:window+1,2:window+1)=1;
            topHaar(pixelY:pixelY+haarY+1,pixelX:pixelX+haarX+1)=0;
            topHaar(pixelY+haarY/3+1:pixelY+haarY*(2/3),pixelX+1:pixelX+haarX)=1;
        else
            topHaar = ones(window).*0.5;
            topHaar(pixelY:pixelY+haarY/3-1,pixelX:pixelX+haarX-1)=0;
            topHaar(pixelY+haarY/3:pixelY+haarY*(2/3)-1,pixelX:pixelX+haarX-1)=1;
            topHaar(pixelY+haarY*(2/3):pixelY+haarY-1,pixelX:pixelX+haarX-1)=0;
        end
%         subplot(subR,subC,i), imshow(topHaar)
%         bestHaar{i} = topHaar;

%⬛⬜⬛
    elseif haar==4
        if bw==1
            topHaar = zeros(window+2);
            topHaar(2:window+1,2:window+1)=1;
            topHaar(pixelY:pixelY+haarY+1,pixelX:pixelX+haarX+1)=0;
            topHaar(pixelY+1:pixelY+haarY,pixelX+haarX/3+1:pixelX+haarX*(2/3))=1;
        else
            topHaar = ones(window).*0.5;
            topHaar(pixelY:pixelY+haarY-1,pixelX:pixelX+haarX/3-1)=0;
            topHaar(pixelY:pixelY+haarY-1,pixelX+haarX/3:pixelX+haarX*(2/3)-1)=1;
            topHaar(pixelY:pixelY+haarY-1,pixelX+haarX*(2/3):pixelX+haarX-1)=0;
        end
%         subplot(subR,subC,i), imshow(topHaar)
%         bestHaar{i} = topHaar;

%⬜⬛
%⬛⬜
    elseif haar==5
        if bw==1
            topHaar = zeros(window+2);
            topHaar(2:window+1,2:window+1)=1;
            topHaar(pixelY:pixelY+haarY+1,pixelX:pixelX+haarX+1)=0;

            topHaar(pixelY+1:pixelY+haarY/2,pixelX+1:pixelX+haarX/2)=1;
            topHaar(pixelY+haarY/2+1:pixelY+haarY,pixelX+haarX/2+1:pixelX+haarX)=1;
        else
            topHaar = ones(window).*0.5;
            topHaar(pixelY:pixelY+haarY/2-1,pixelX:pixelX+haarX/2-1)=1;
            topHaar(pixelY:pixelY+haarY-1,pixelX+haarX/2:pixelX+haarX-1)=0;
            topHaar(pixelY+haarY/2:pixelY+haarY-1,pixelX:pixelX+haarX-1)=0;
            topHaar(pixelY+haarY/2:pixelY+haarY-1,pixelX+haarX/2:pixelX+haarX-1)=1;
        end
%         subplot(subR,subC,i), imshow(topHaar)
%         bestHaar{i} = topHaar;
    end
    
    subplot(subR,subC,i), imshow(topHaar)
    title(int2str(threshold))
end