%% Exercise 2
close all; clear; clc

n=9;  % # nodes
m=20; % # edges

%   [ 1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20];
S=  [ 1  3  3  3  5  5  5  6  6  6  7  7  7  7  7  8  8  9  9  9]; % starting node
E=  [ 5  7  8  9  4  6  7  2  5  7  2  4  5  6  9  7  9  2  6  8]; % ending node
C=  [ 3  6  4  5  9  5  4  6  6  4  5  4  7  3  5  5  3  5  2  5]; % cost
W=  [ 9  4  3  2  4  2  5  4  5  4  5  4  5  2  4  5  4  3  5  3]; % capacity

Aeq=[ 1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0; %constraint for node 1
      0  0  0  0  0  0  0 -1  0  0 -1  0  0  0  0  0  0 -1  0  0; %constraint for node 2
      0  1  1  1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0; %constraint for node 3
      0  0  0  0 -1  0  0  0  0  0  0 -1  0  0  0  0  0  0  0  0; %constraint for node 4
     -1  0  0  0  1  1  1  0 -1  0  0  0 -1  0  0  0  0  0  0  0; %constraint for node 5
      0  0  0  0  0 -1  0  1  1  1  0  0  0 -1  0  0  0  0 -1  0; %constraint for node 6
      0 -1  0  0  0  0 -1  0  0 -1  1  1  1  1  1 -1  0  0  0  0; %constraint for node 7
      0  0 -1  0  0  0  0  0  0  0  0  0  0  0  0  1  1  0  0 -1; %constraint for node 8
      0  0  0 -1  0  0  0  0  0  0  0  0  0  0 -1  0 -1  1  1  1];%constraint for node 9

 
    % 1  2  3  4  5  6  7  8  9 node
beq=[ 9 -7  6 -8  0  0  0  0  0]'; % supplies and demands
lb=zeros(20,1);
ub=W;
[xmin, fval, flag]=linprog(C,[],[],Aeq,beq,lb,ub);

if flag==1
    fprintf('Function converged to a solution x.')
end

from_to = [S;E];
solution = [S;E;xmin']
Cost_flow = fval

nodes = 1:n;
supply = nodes.*(beq>0)';
supply = supply(supply~=0)

from_to = from_to.*(xmin~=0)';
from_to = from_to(from_to~=0);
from_to = reshape(from_to,2,length(from_to)/2)
S = from_to(1,:);
E = from_to(2,:);
flow = xmin(xmin~=0);

x = [0 6 3 3 2 4 3 2 4]
y = [3 3 0 6 4 4 3 2 2]

hold on
for i=1:length(S)
    p1 = [x(S(i)) y(S(i))];            % First Point
    p2 = [x(E(i)) y(E(i))];      % Second Point
    dp = p2-p1;                      % Difference
    quiver(p1(1),p1(2),dp(1),dp(2), ...
        'AutoScale','on', ...
        'AutoScaleFactor',1, ...
        'MaxHeadSize',0.5, ...
        'Color','black')
    text(x(S(i))-0.1+dp(1)/2,y(S(i))+0.2+dp(2)/2,num2str(flow(i)),'Color','#77AC30','FontSize',15,'HorizontalAlignment','center')
end
for i=1:n
plot(x(i),y(i),'o','MarkerSize',20,'Color','r','MarkerFaceColor','b')
text(x(i),y(i),num2str(i),'Color','w','FontSize',15,'HorizontalAlignment','center')
end
grid on
