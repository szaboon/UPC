%% Exercise3
close all; clear; clc

n=10; % number of points
m = n*(n-1);
% P=zeros(n,2); % inicialize point's coordinates
D=zeros(n,n); % inicialize distance matrix
P=rand(n,2)*10; % generate n random points
rectangle('Position',[0 0 10 10])
axis([-1 11 -1 11])
hold on
plot(P(:,1),P(:,2),'rx') % draw the points as red crosses
for i=1:(n-1) % calculate distance matrix
    for j=(i+1):n
        D(i,j)=norm(P(i,:)-P(j,:));
        D(j,i)=D(i,j);
    end
end

%% Calculates the vector f
%
% f= # of cities, D(i,j)=distance from city i to city j
% f must be a vector of 2·n·(n-1) coeficients associated to the variables
% x(1), x(2),...,x(n·(n-1)), y(1), y(2),...,y(n·(n-1))
% writes the distance matrix D in a one dimensional vector
f=reshape(D,1,n*n);
% deletes variables related with edges ii (size(f)=n*(n-1))
f=f(f~=0);
% add to the previous vector n·(n-1) coeficients associated to the y variables
f=[f,zeros(1,n*(n-1))];

%% A matrix

o = ones(1,n-1);
z = zeros(1,n-1);
e = eye(n);

A1 = [];
for i=1:n
    r = [];
    for j=1:n
        if i==j
            r = [r,o];
        else
            r = [r,z];
        end
    end
    A1(i,:) = r;
end

A2 = [];
for i=1:n
    A2 = [A2,z];
    for j=1:n
        if i==n
            break
        end
        A2 = [A2,e(i,1:n-1)];
    end
end
A2 = reshape(A2',[],n)';

A1;
A2;
A3=A1-A2;
A4=-(n-1)*eye(m);

O = zeros(n,m);

Aeq = [A1  O;
       A2  O;
        O A3];
beq = [ones(2*n,1);n-1;-ones(n-1,1)];

A = [A4, eye(m)];
b = zeros(m,1);
lb=zeros(2*m,1);
ub=[ones(m,1);100*ones(m,1)];
[x,fval]=intlinprog(f,1:(2*m),A,b,Aeq,beq,lb,ub);

dist = x.*f';
m1 = reshape(dist(1:m),[],n-1);         % Matrix with n-1 columns
m2 = [zeros(1,n-1); m1];                % Adding diagonal zeros
M = reshape([reshape(m2,[],1);0],[],n);  % Reshaping final matrix

%% Plotting traveling lines

l = [];
for i=1:n
    l(i) = find(M(i,:));
end
for i=1:n
%     line([P(i,1),P(l(i),1)],[P(i,2),P(l(i),2)])
    p1 = [P(i,1) P(i,2)];            % First Point
    p2 = [P(l(i),1) P(l(i),2)];      % Second Point
    dp = p2-p1;                      % Difference
    quiver(p1(1),p1(2),dp(1),dp(2), ...
        'AutoScale','on', ...
        'AutoScaleFactor',1, ...
        'MaxHeadSize',0.3, ...
        'Color','b')
end

