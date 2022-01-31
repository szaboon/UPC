% Traveling salesperson
n=5; % number of nodes
E1=[1 2;1 3;1 5;2 3;2 4;2 5;3 5;4 5]; % edges
f1=[2 2 4 3 2 5 3 6]; % edges length
E=[E1;E1(:,[2,1])]; % directed edges
N=size(E,1); % number of directed edges
f=[f1,f1]; % directed edges length
f=[f,zeros(1,16)];
A1=[1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 0 1 1 1 0 0 1 0 0 0 0 0 0 0;
    0 0 0 0 0 0 1 0 0 1 0 1 0 0 0 0;
    0 0 0 0 0 0 0 1 0 0 0 0 1 0 0 0;
    0 0 0 0 0 0 0 0 0 0 1 0 0 1 1 1];
A2=[0 0 0 0 0 0 0 0 1 1 1 0 0 0 0 0;
    1 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0;
    0 1 0 1 0 0 0 0 0 0 0 0 0 0 1 0;
    0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1;
    0 0 1 0 0 1 1 1 0 0 0 0 0 0 0 0];
A3=A1-A2;
O=zeros(5,16);
Aeq=[A1,O; A2,O; O,A3];
beq=[ones(10,1);[4;-1;-1;-1;-1]]
A=[-4*eye(16),eye(16)];
b=zeros(16,1);
lb=zeros(32,1);ub=[ones(16,1);100*ones(16,1)];
[x,fval]=intlinprog(f',1:16,A,b,Aeq,beq,lb,ub);
reshape(x,[],2)