%% Exercise 1
close all; clc; clear

w=[2 15 15 42 15 10 20 25 5 16 15 23]; % weights
v=[200 500 600 1000 300 600 800 800 300 600 600 1000]; % values
W=100; % capacity
A=[ w                                    % constraint 1
    0  1  0  0  0  0  0  0  1  0  0  0;  % constraint 3
    0 -1  2  0  0 -1  0  0  0  0  0  0;  % constraint 4
    0  0  0  0  0  0  0 -1  1  0  0  0;  % constraint 7
    0  0  0  0  0  0  0  0  0  0 -1 -1]; % constraint 8
   
%   1  3  4  7  8  
b= [W  1  0  0 -1];

Aeq=[ 1  0  0  0  0  0  0  0  0  0  0  0;  % constraint 2
      0  0  0  1 -1  0  0  0  0  0  0  0;  % constraint 5
      0  0  0  0  0  1  1  1  0  0  0  0]; % constraint 6

%     2  5  6
beq=[ 1  0  2];
lb=zeros(1,12);ub=ones(1,12);
[sol, val]=intlinprog(-v,1:12,A,b,Aeq,beq,lb,ub);

solution = sol
backpack_weight = sum(sol.*w')
backpack_value = val

