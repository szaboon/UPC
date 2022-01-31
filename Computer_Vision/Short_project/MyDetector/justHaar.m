
% Haar 1
hf = [10,30];           %          0,0    |      |
f_val = [];             % ⬛⬛      ----A+------+B
for i=1:u-2*hf(1)       % ⬜⬜      ----C+------+C
    for j=1:v-hf(2) %    D         -     C       -      B      +  A   
        black = II(i+hf(1),j+hf(2))-II(i+hf(1),j)-II(i,j+hf(2))+II(i,j);
        white = II(i+2*hf(1),j+hf(2))-II(i+2*hf(1),j)-II(i+hf(1),j+hf(2))+II(i+hf(1),j);
        f_val1(i,j) = white-black;
    end 
end

% Haar 2
hf = [20,10];          %             0,0    |      |
f_val = [];             % ⬛⬜⬛      ----A+------+B
for i=1:u-hf(1)         % ⬛⬜⬛      ----C+------+D
    for j=1:v-3*hf(2) %    D         -     C       -      B      +  A  
        black1 = II(i+hf(1),j+hf(2))-II(i+hf(1),j)-II(i,j+hf(2))+II(i,j);
        white = II(i+hf(1),j+2*hf(2))-II(i+hf(1),j+hf(2))-II(i,j+2*hf(2))+II(i,j+hf(2));
        black2 = II(i+hf(1),j+3*hf(2))-II(i+hf(1),j+2*hf(2))-II(i,j+3*hf(2))+II(i,j+2*hf(2));
        f_val2(i,j) = white-black1-black2;
    end 
end

figure, imshow(f_val1,[])
figure, imshow(f_val2,[])

f_val = f_val1.*f_val2;
max_f_val = max(max(f_val));
[i,j] = find(f_val==max_f_val);

hf = [25,90];
Y = i+hf(1);
X = j+hf(2)/2;
[X,Y];

figure,
imshow(I), hold on
plot(X,Y,'r*','MarkerSize',10)
rectangle('Position',[X(1)-(hf(2)/2),Y(1)-(hf(1)),hf(2),2*hf(1)],'EdgeColor','r'),
