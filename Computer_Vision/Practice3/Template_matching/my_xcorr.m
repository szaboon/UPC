function result=my_xcorr(Search_img,Template)

% Changing image to gray levels
Search_img_gray=rgb2gray(Search_img);
Template_gray=rgb2gray(Template);

% Sizes of the images
[r1,c1]=size(Search_img_gray);
[r2,c2]=size(Template_gray);

% Subtract the mean value so that there are roughly equal numbers of
% negative and positive values.
Temp_mean=Template_gray-mean(mean(Template_gray));

% Doing cross correlation on every sliding image under mask
corrMat=[];
for i=1:(r1-r2+1)
    for j=1:(c1-c2+1)
        % Sliding mask(Template) on every image and substracting mean
        img_under_mask=Search_img_gray(i:i+r2-1,j:j+c2-1);
        img_under_mask=img_under_mask-mean(mean(img_under_mask));  
        % Calculating sum of cross correlation
        corr=sum(sum(img_under_mask.*Temp_mean));
        corrMat(i,j)=corr;
    end 
end

% Finding maximum correlation

[r,c]=max(corrMat);
[r3,c3]=max(max(corrMat));

i=c(c3);    % Number of row with max. correlation
j=c3;       % Number of column with max. correlation

% Bounding box coordinates 
x = i;
y = j;
X = i+r2-1;
Y = j+c2-1;

result = [x,y,X,Y];
