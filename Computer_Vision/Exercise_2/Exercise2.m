

I = [0  0  0  0  0  0  0  0 90 90 90  0;
     0 90 90 90  0  0  0  0  0 90  0  0;
     0 90 90 90  0  0  0  0  0  0  0  0;
     0 90 90 90  0  0  0 90 90  0  0  0;
     0 90 90 90  0  0  0 90 90  0  0  0;
     0 90 90 90  0  0  0 90 90  0  0  0;
     0  0 90 90 90 90 90 90 90  0  0  0;
     0  0  0 90 90 90 90 90 90  0  0  0;
     0  0  0  0 90 90 90  0  0  0 90 90;
     0  0  0  0  0 90  0  0  0 90 90  0;
     0 90  0  0  0  0  0  0 90 90  0  0;
     0  0  0  0  0  0  0  0  0  0  0  0];

% binarization
% Ib = imbinarize(I);
Ib = I>89

%% Conectivity analysis
M = zeros(size(I));
label = 4;  % first label
% top-down, left-right          % ⬜⬜⬜
for i = 1:size(I,1)             % ⬜⬛->
    for j = 1:size(I,2)         %    v
        if i==1 && j==1
            if Ib(i,j)==1; M(i,j)=label; end
        elseif i==1
            if Ib(i,j)==1
                if M(i,j-1)~=0; M(i,j)=M(i,j-1);
                elseif Ib(i,j)==1; M(i,j)=label;
                else
                    label=label+1; 
                    M(i,j)=label;
                end
            end
        elseif j==1
            if Ib(i,j)==1
                if M(i-1,j)~=0; M(i,j)=M(i-1,j);
                elseif M(i-1,j+1)~=0; M(i,j)=M(i-1,j); 
                else
                    label=label+1; 
                    M(i,j)=label;
                end
            end
        elseif j==size(I,1)
            if Ib(i,j)==1
                if M(i-1,j-1)~=0; M(i,j)=M(i-1,j-1);
                elseif M(i,j-1)~=0; M(i,j)=M(i,j-1);
                elseif M(i-1,j)~=0; M(i,j)=M(i-1,j);
                else 
                    label=label+1; 
                    M(i,j)=label;
                end
            end
        else
            if Ib(i,j)==1
                if M(i-1,j-1)~=0; M(i,j)=M(i-1,j-1);
                elseif M(i,j-1)~=0; M(i,j)=M(i,j-1);
                elseif M(i-1,j)~=0; M(i,j)=M(i-1,j);
                elseif M(i-1,j+1)~=0; M(i,j)=M(i-1,j+1);
                else 
                    label=label+1; 
                    M(i,j)=label;
                end
            end
        end
    end
end
M
% fixing wrongly classified          ^
% down-top, left-right          % ⬜⬛->
for i = size(I,1):-1:1          % ⬜⬜⬜
    for j = 1:size(I,2)
        if i==size(I,1) && j==1
            if M(i,j)~=0; M(i,j)=label; end
        elseif i==size(I,1)
            if M(i,j)~=0
                if M(i,j-1)~=0; M(i,j)=M(i,j-1);
                end
            end
        elseif j==1
            if M(i,j)~=0
                if M(i+1,j)~=0; M(i,j)=M(i+1,j);
                elseif M(i+1,j+1)~=0; M(i,j)=M(i+1,j);
                end
            end
        elseif j==size(I,1)
            if M(i,j)~=0
                if M(i+1,j-1)~=0; M(i,j)=M(i+1,j-1);
                elseif M(i,j-1)~=0; M(i,j)=M(i,j-1);
                elseif M(i-1,j)~=0; M(i,j)=M(i-1,j);
                end
            end
        else
            if M(i,j)~=0
                if M(i+1,j-1)~=0; M(i,j)=M(i+1,j-1);
                elseif M(i,j-1)~=0; M(i,j)=M(i,j-1);
                elseif M(i+1,j)~=0; M(i,j)=M(i+1,j);
                elseif M(i+1,j+1)~=0; M(i,j)=M(i+1,j+1);
                end
            end
        end
    end
end
M

%% Eliminating areas with less tha 5 pixels

regions = unique(M);    % numbers of regions
regions(regions==0)=[]; % taking out the background (0)

% Eliminatig regions with less then 5 pixels
length(regions)
for a = 1:length(regions)
    [r,c] = find(M==regions(a));
    if length(r)<6
        Ib(r,c)=0;
        M(r,c)=0;
    end
end
Ib
regions

%% Contour extraction
M2 = zeros(size(I,1)+2);    % Changing size for contour calculation
M2(2:size(I,1)+1,2:size(I,2)+1) = M; % Putting the original M matrix inside
C = double(M2>1);    % Creating bigger matrix only of ones

% looking first first pixel
i = 1;
j = 1;
regions_left = unique(M2);
regions_left(regions_left==0)=[];

coordinates = {}; % Saving contour coordinates
for r = 1:length(regions_left)
    i = 1;
    j = 1;
    while M2(i,j)~=regions_left(r)
        j = j+1;
        if j==size(C,2)
            i=i+1;
            j=1;
        end
    end
    % found first pixel
    ic=i;
    jc=j;


    % d position
    id=ic-1;
    jd=jc;
    
    % changing values
    C(ic,jc)=3;
    C(id,jd)=2;
    
    % turning clockwise     % k  8 1 2
    fprintf('teraz')        %    7 x 3
    end_found=0;            %    6 5 4
    k=2;
    coord = [];
    while end_found==0
        X=0;
        while X==0
            if k==1
                if C(ic-1,jc)==1||C(ic-1,jc)==3||C(ic-1,jc)==4; ie=ic-1; je=jc;X=1;end
            elseif k==2
                if C(ic-1,jc+1)==1||C(ic-1,jc+1)==3||C(ic-1,jc+1)==4; ie=ic-1; je=jc+1;X=1;end
            elseif k==3
                if C(ic,jc+1)==1||C(ic,jc+1)==3||C(ic,jc+1)==4; ie=ic; je=jc+1;X=1;end
            elseif k==4
                if C(ic+1,jc+1)==1||C(ic+1,jc+1)==3||C(ic+1,jc+1)==4; ie=ic+1; je=jc+1;X=1;end
            elseif k==5
                if C(ic+1,jc)==1||C(ic+1,jc)==3||C(ic+1,jc)==4; ie=ic+1; je=jc;X=1;end
            elseif k==6
                if C(ic+1,jc-1)==1||C(ic+1,jc-1)==3||C(ic+1,jc-1)==4; ie=ic+1; je=jc-1;X=1;end
            elseif k==7
                if C(ic,jc-1)==1||C(ic,jc-1)==3||C(ic,jc-1)==4; ie=ic; je=jc-1;X=1;end
            elseif k==8
                if C(ic-1,jc-1)==1||C(ic-1,jc-1)==3||C(ic-1,jc-1)==4; ie=ic-1; je=jc-1;X=1;end
            end
    
            if k==8; k=1; else; k=k+1; end
        end
    
        ik=ie-ic;
        jk=je-jc;
        if ik==-1 && jk==0;     k=8;
        elseif ik==-1 && jk==1; k=1;
        elseif ik==0 && jk==1;  k=2;
        elseif ik==1 && jk==1;  k=3;
        elseif ik==1 && jk==0;  k=4;
        elseif ik==1 && jk==-1; k=5;
        elseif ik==0 && jk==-1; k=6;
        elseif ik==-1 && jk==-1;k=7;
        end
    
        ic=ie;
        jc=je;
        coord = [coord; ic-1,jc-1];
    
        if C(ic,jc)==1
            C(ie,je)=4;
        elseif  C(ic,jc)==3
            C(ic,jc)=4;
            C(C==2)=0;
            end_found=1;
        end
    end
    coordinates{r} = coord;
end
C=C(2:size(I,1)+1,2:size(I,2)+1);
C(C==1)=0
 
%% Moreover, obtain the area, geometric center, orientation and magnitude and compacity.

for region = 1:length(regions_left)
    fprintf(strcat('\nSpecifications for region: ',int2str(region),'\n'))
    % Contour 1
    Contour = coordinates{1}
    
    % Perimeter 1
    C2 = C>1;
    C3 = M.*C2;
    Perimeter = length(C3(C3==regions_left(1)))
    
    % Area 1
    Area = length(M(M==regions_left(1)))
    
    % Geometric Center
    [y,x] = find(M==regions_left(1));
    
    x_center = sum(x/Area)
    y_center = sum(y/Area)
    
    % Orientation and magnitude
    M11 = sum(((x.*y)/Area))-x_center*y_center
    M02 = sum(((y.^2)/Area))-y_center^2
    M20 = sum(((x.^2)/Area))-x_center^2
    
    G = [0.5*(M02+M20)+sqrt((M02-M20)^2-4*M11^2);
         0.5*(M02+M20)-sqrt((M02-M20)^2-4*M11^2)]
    
    Theta = 0.5*atan(2*M11/(M02-M20))
    
    % Compacity
    Compacity = Perimeter/Area
end


