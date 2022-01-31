function mask=gaussian_filter_2(sigma_x,sigma_y,sx,sy,r)
    % x     - deviation in x 
    % y     - deviation in y 
    % sx    - mask size in x
    % sy    - mask size in y
    % r     - filter rotation angle
    %dx = [-1 0 1; -1 0 1; -1 0 1];
    % Both of them 0 in order to center the 2D Gaussian function 
    % at the filter mask midpoint
    mu_x = 0; mu_y = 0; 

    % Generate horizontal and vertical co-ordinates, depending
    % on the size and with the origin in the middle
    [X,Y]=meshgrid((-(sx-1)/2):((sx-1)/2), (-(sy-1)/2):((sy-1)/2))
    
    % Application of the rotation angle
    x = cos(r)*(X)-sin(r)*(Y);
    y = sin(r)*(X)+cos(r)*(Y);

    % Probability density function (pdf) for one dimension in each equation
    Gx = 1/(sigma_x*sqrt(2*pi))*exp(-(x-mu_x).^2/(2*sigma_x^2));
    Gy = 1/(sigma_y*sqrt(2*pi))*exp(-(y-mu_y).^2/(2*sigma_y^2));

    % Creation of the Gaussian Mask in two dimensions (x,y)
    G1 = Gx.*Gy;
    dx = [-1 0 1; -1 0 1; -1 0 1];
    G = imfilter(G1,dx);
    % Normalization so that total area (sum of all weights) is 1
    mask = G / sum(G(:));
end