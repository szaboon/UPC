function result=my_xcorr_new(Search_img,Template)

% Changing image to gray levels
Search_img_gray=rgb2gray(Search_img);
Template_gray=rgb2gray(Template);

% Sizes of the images
[r1,c1]=size(Search_img_gray);
[r2,c2]=size(Template_gray);

% Subtract the mean value so that there are roughly equal numbers of
% negative and positive values.
Temp_mean=Template_gray-mean(mean(Template_gray));

% Unequalzed image in columns
img_col_uneq = im2col(Search_img_gray,[r2 c2], 'sliding');
% Equalized image in columns
img_columns = img_col_uneq-uint8(ones(size(img_col_uneq)).*mean(img_col_uneq));
% Column from Template
Temp_col = Temp_mean(:);
% Matrix of Template columns with size of the img_columns
Temp_columns = uint8(ones(size(img_columns))).*Temp_col;
% Calculatin Cross Correlation
corr = sum(img_columns.*Temp_columns);
% Creating Correlation Matrix
corrMat = col2im(corr,[1 1],[r1-r2+1 c1-c2+1]);


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