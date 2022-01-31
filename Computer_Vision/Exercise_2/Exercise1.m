%% Exercise 1
clc, clear

%% Matrix 1
fig1 = [0 2 0 1 0
        1 0 1 1 0
        0 0 2 0 0
        1 1 0 0 2
        0 0 1 1 0];

% d(1,1)
P1 = {};
P = zeros(3,3);
for i = 1:size(fig1,1)-1
    for j = 1:size(fig1,2)-1
        r = fig1(i,j)+1;
        c = fig1(i+1,j+1)+1;
        P(r,c) =  P(r,c)+1;
    end
end
P1{1} = P/sum(sum(P));

% d(1,0)
P = zeros(3,3);
for i = 1:size(fig1,1)-1
    for j = 1:size(fig1,2)
        r = fig1(i,j)+1;
        c = fig1(i+1,j)+1;
        P(r,c) =  P(r,c)+1;
    end
end
P1{2} =  P/sum(sum(P));

% d(0,1)
P = zeros(3,3);
for i = 1:size(fig1,1)
    for j = 1:size(fig1,2)-1
        r = fig1(i,j)+1;
        c = fig1(i,j+1)+1;
        P(r,c) =  P(r,c)+1;
    end
end
P1{3} =  P/sum(sum(P));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Matrix 2
fig2 = [0 1 0 1 0
        0 1 0 1 0
        0 1 0 1 0
        0 1 0 1 0
        0 1 0 1 0];

% d(1,1)
P2 = {};
P = zeros(2,2);
for i = 1:size(fig2,1)-1
    for j = 1:size(fig2,2)-1
        r = fig2(i,j)+1;
        c = fig2(i+1,j+1)+1;
        P(r,c) =  P(r,c)+1;
    end
end
P2{1} = P/sum(sum(P));
% d(1,0)
P = zeros(2,2);
for i = 1:size(fig2,1)-1
    for j = 1:size(fig2,2)
        r = fig2(i,j)+1;
        c = fig2(i+1,j)+1;
        P(r,c) =  P(r,c)+1;
    end
end
P2{2} =  P/sum(sum(P));
% d(0,1)
P = zeros(2,2);
for i = 1:size(fig2,1)
    for j = 1:size(fig2,2)-1
        r = fig2(i,j)+1;
        c = fig2(i,j+1)+1;
        P(r,c) =  P(r,c)+1;
    end
end
P2{3} =  P/sum(sum(P));

%%%%%% ENTROPY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Entropy1 = zeros(3,1);
Homogenity1 = zeros(3,1);
Energy1 = zeros(3,1);
for p = 1:3
    P = P1{p}
    for i = 1:3
        for j = 1:3
            if P(i,j)==0
                Entropy1(p) = Entropy1(p);
                Homogenity1(p) = Homogenity1(p);
            else
                Entropy1(p) = Entropy1(p) + P(i,j)*log(P(i,j));
                Homogenity1(p) = Homogenity1(p) + P(i,j)/(1+abs(i-j));
            end
        end
    end
    Entropy1(p) = -Entropy1(p);
    Energy1(p) = sum(sum(P.^2));
end

Entropy2 = zeros(3,1);
Homogenity2 = zeros(3,1);
Energy2 = zeros(3,1);
for p = 1:3
    P = P2{p}
    for i = 1:2
        for j = 1:2
            if P(i,j)==0
                Entropy2(p) = Entropy2(p);
                Homogenity2(p) = Homogenity2(p);
            else
                Entropy2(p) = Entropy2(p) + P(i,j)*log(P(i,j));
                Homogenity2(p) = Homogenity2(p) + P(i,j)/(1+abs(i-j));
            end
        end
    end
    Entropy2(p) = -Entropy2(p);
    Energy2(p) = sum(sum(P.^2));
end


ent_ener_homo_1 = [Entropy1,Energy1,Homogenity1]
ent_ener_homo_2 = [Entropy2,Energy2,Homogenity2]
