%% Try

mask = [1, 128, 64; % Mask used to generate a unique decimal number [0-511] that corresponds to a specific configuration of 9 pixels
        2, 256, 32;
        4, 8  , 16];

im_out = double(('images\chipmunk.png'));

    
LUT_1 = zeros(1,512); % Prealocation of the LUT for both subietrations.
LUT_2 = zeros(1,512);
% im(i,j) < 256 => pixel(i,j) == 0 => LUT(N) = 0
for i = 255:511
    LUT_1(i+1) = lookup_function_1(i);
    LUT_2(i+1) = lookup_function_2(i);
end


while(any(im_thin_1,'all') || any(im_thin_2,'all'))
    im_aux = imfilter(im_out,mask);
    im_thin_1 = LUT_1(im_aux+1); % obtains the pixels to be eliminated
    im_out = im_out-im_thin_1; % eliminate the pixels from the im

    im_aux = imfilter(im_out,mask);
    im_thin_2 = LUT_2(im_aux+1);
    im_out = im_out-im_thin_2; 

%    any(im_thin,'all')
end




function [out] = lookup_function_1(N)
    bin = dec2bin(N);
    bin_sum = sum(bin == '1');
    if (bin_sum > 2 && bin_sum <8) % Condition 1. 
        bin = [bin(2:end), bin(2)]; % Rearange the external pixels in a vector form.
        sum_t = 0;
        for j = 1:8
            if(bin(j) == '0' && bin(j+1) == '1') % Count transitions from 0 to 1 for the cyclic external pixels
                sum_t = sum_t + 1;
            end
        end
        if( sum_t == 1)
            bool2 = bin(1) == '0' | bin(3) == '0' | bin(5) == '0'; %Condition 3.
            bool3 = bin(3) == '0' | bin(5) == '0' | bin(7) == '0'; %Condition 4. 
            out = bool2 && bool3; % If all the previous conditions are verified, we asign a 1 in the LUT
        else
            out = 0;
        end
    else
        out = 0;
    end
    
end


function [out] = lookup_function_2(N)
    bin = dec2bin(N);
    bin_sum = sum(bin == '1');
    if (bin_sum > 2 && bin_sum <8) % Condition 1. 
        bin = [bin(2:end), bin(2)]; % Rearange the external pixels in a vector form
        sum_t = 0;
        for j = 1:8 
            if(bin(j) == '0' && bin(j+1) == '1') % Count transitions from 0 to 1 for the cyclic external pixels
                sum_t = sum_t + 1;
            end
        end
        if( sum_t == 1) % Condition 2. 
            bool2 = bin(1) == '0' | bin(5) == '0' | bin(7) == '0'; %Condition 3.
            bool3 = bin(1) == '0' | bin(3) == '0' | bin(7) == '0'; %Condition 4. 
            out = bool2 && bool3; % If all the previous conditions are verified, we asign a 1 in the LUT
        else
            out = 0;
        end
    else
        out = 0;
    end
    
end