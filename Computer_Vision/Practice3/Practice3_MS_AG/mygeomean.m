function geo_mean = mygeomean(im_col)

% Calculating product of all the pixels in the neigbourhood
product = prod(im_col);

% Raising the result to the power 1/(m*n)
geo_mean = product.^(1/size(im_col,1));

end