function result=my_SAD(Search_img,Template)

% Changing image to gray levels
% We are also changing image to normal integer because uint8 number don't 
% go below zero and in SAD technique its necesary because we will alway get
% the darkest part of the image as a result, but this way we are summing
% absolute value of negative numbers
Search_img_gray=int8(rgb2gray(Search_img));
Template_gray=int8(rgb2gray(Template));

% Sizes of the images
[r1,c1]=size(Search_img_gray);
[r2,c2]=size(Template_gray);

% Calculating difference between sliding image and the mask above (Template) 
SAD_Mat=[];
for i=1:(r1-r2+1)
    for j=1:(c1-c2+1)
        % Sliding mask(Template) on every image
        img_under_mask=Search_img_gray(i:i+r2-1,j:j+c2-1);
        % Calculating sum of the difference
        SAD=sum(sum(abs(img_under_mask-Template_gray)));
        SAD_Mat(i,j)=SAD;
    end 
end

% Finding maximum correlation
[r,c]=min(SAD_Mat);
[r3,c3]=min(min(SAD_Mat));

i=c(c3);    % Number of row with max. correlation
j=c3;       % Number of column with max. correlation

% Bounding box coordinates 
x = i;
y = j;
X = i+r2-1;
Y = j+c2-1;

result = [x,y,X,Y];
