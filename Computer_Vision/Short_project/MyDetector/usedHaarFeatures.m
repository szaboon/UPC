% Copying best Haar features from Viola-Jones article 

close all;
a=1;
window = floor(a*24);

j = floor(a*6);
i = floor(a*8);
haarX = floor(a*14);
haarY = floor(a*6);
topHaar = zeros(window);
topHaar(2:window-1,2:window-1)=1;

topHaar(i-1:i+haarY,j-1:j+haarX)=0;

topHaar(i:i+floor(haarY/2)-1,j:j+haarX-1)=0;
topHaar(i+floor(haarY/2):i+haarY-1,j:j+haarX-1)=1;
figure, imshow(topHaar)



j = floor(a*8);
i = floor(a*4);
haarX = floor(a*9);
haarY = floor(a*5);
topHaar = zeros(window);
topHaar(2:window-1,2:window-1)=1;

topHaar(i-1:i+haarY,j-1:j+haarX)=0;

topHaar(i:i+haarY-1,j:j+floor(haarX/3)-1)=0;
topHaar(i:i+haarY-1,j+ceil(haarX/3):j+floor(haarX*(2/3))-1)=1;
topHaar(i:i+haarY-1,j+ceil(haarX*(2/3)):j+haarX-1)=0;
figure, imshow(topHaar)


