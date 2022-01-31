function im2 = myhisteq(im, bins)

% Creating new image with unit8 numbers
im2 = uint8(zeros(size(im,1),size(im,2)));

h = imhist(im);     % Counting the occurrence of each pixel value
c = cumsum(h);      % Cumulative distribution
pc = c/numel(im);   % Cumulative distribution probability

% Coefficient K
K = 255/(bins-1);

output = round(pc.*bins)*K;   % Calculating output

% Giving calculated values to each pixel of the new image

for i=1:size(im,1)
    for j=1:size(im,2)
            im2(i,j)=output(im(i,j)+1);
    end
end

