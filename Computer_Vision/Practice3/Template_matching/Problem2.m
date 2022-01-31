% main file 
close all
clear all
clc


img = imread('money.tif');
White = 255;

imagesc(img)
axis image off
colormap gray
title('Original')

x = 200;
X = 300;
szx = x:X;

y = 62;
Y = 182;
szy = y:Y;

Sect = img(szx,szy);

kimg = img;
kimg(szx,szy) = White;

kumg = White*ones(size(img));
kumg(szx,szy) = Sect;

subplot(1,2,1)
imagesc(kimg)
axis image off
colormap gray
title('Image')

subplot(1,2,2)
imagesc(kumg)
axis image off
colormap gray
title('Section')

nimg = img-mean(mean(img));
nSec = nimg(szx,szy);

figure
subplot(1,2,1), imshow(img), colormap gray, title('Image')
subplot(1,2,2), imshow(nimg), colormap gray, title('NImage')


%% my correlation
crr = xcorr2(nimg,nSec);

Target = img;
Template = nSec;

[r1,c1] = size(Target);
[r2,c2] = size(Template);

% crr = [];
% for i=1:(r1-r2+1)
%     for j=1:(c1-c2+1)
%         Nimage=Target(i:i+r2-1,j:j+c2-1);
%         Nimage=Nimage-mean(mean(Nimage));  % mean of image part under mask
%         corr=sum(sum(Nimage.*Template));
%         warning off
%         crr(i,j)=sqrt(corr.^2);%/sqrt(sum(sum(Nimage.^2)));
%     end 
% end




[ssr,snd] = max(crr(:))
[ij,ji] = ind2sub(size(crr),snd);

figure
plot(crr(:))
title('Cross-Correlation')
hold on
plot(snd,ssr,'or')
hold off
text(snd*1.05,ssr,'Maximum')

iss = rot90(Sect,2);
imshow(iss)

img(ij:-1:ij-size(Sect,1)+1,ji:-1:ji-size(Sect,2)+1) = rot90(Sect,2);



figure
imagesc(img)
axis image off
colormap gray
title('Reconstructed')
hold on
plot([y y Y Y y],[x X X x x],'r')
hold off