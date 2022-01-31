'Author: Michal Szabo';
'Date: 10.12.2021';
clear, clc

%% Act1.1 Numerical.m without constraints
close all; clear, clc

A=[1, 1; 1,0];
B=[1;0];    % control matrix
Q=eye(2)*2;   % weight of states in obj function
R=1;        % weight of control action in obj function
N=10;       % horizon 

nu = 1; % number of inputs
nx = 2; % number of states

u = sdpvar(repmat(nu,1,N),repmat(1,1,N));
x = sdpvar(repmat(nx,1,N+1),repmat(1,1,N+1));

x{1}=[1;1];

constraints = [];
objective = 0;

% Revise the following Yalmip code and understand how it works
for k = 1:N
    objective = objective + transpose(x{k})*Q*x{k} + transpose(u{k})*R*u{k};
    constraints = [constraints, x{k+1} == A*x{k} + B*u{k}];
end
options = sdpsettings('solver', 'quadprog');
optimize(constraints,objective,options);
xopt(:,1)=[1;1];

% Calculus of u and x
for k=1:N
 uopt(k)=value(u{k});
 xopt(:,k+1)=A*xopt(:,k)+B*uopt(k);
end

figure,
subplot(3,1,1), plot(linspace(1,11,11),xopt(1,:)), title('state x1')
subplot(3,1,2), plot(linspace(1,11,11),xopt(2,:)), title('state x2')
subplot(3,1,3), plot(linspace(1,10,10),uopt(1,:)), title('action control u')

Je = 0; 
Ju = 0; 
for k = 1:N 
    Je = Je + value(x{k}')*Q*value(x{k});
    Ju = Ju + value(u{k}')*R*value(u{k});
end

figure
plot(Ju,Je,'*')
title('Changing R=1:20')
xlabel('Energy consumption (Ju)')
ylabel('Tracking error (Je)')

%% Act1.3 Riccati.m Analytical optimal solution solution
close all; clc

A=[1, 1; 1,0]; % system matrix
B=[1;0]; % control matrix
Q=eye(2); % weight of states in obj function
S=Q; % weight of final state in obj function
R=1; % weight of control action in obj function
N=100; % horizon

%Initialization
P=zeros(2,2,N+1); % P matrix
K=zeros(1,2,N); % gain
u=zeros(1,N); % control action
x=zeros(2,N+1); % states
x(:,1)=[1,1]; % initial conditions

% Riccati equation backwards recursion
P(:,:,N+1)=S;
for k=N:-1:1
 P(:,:,k)=Q+A'*P(:,:,k+1)*inv(eye(2)+B*inv(R)*B'*P(:,:,k+1))*A;
 K(:,:,k)=inv(R+B'*P(:,:,k+1)*B)*B'*P(:,:,k+1)*A;
end

% Calculus of u and x
for k=1:N
 u(k)=-K(:,:,k)*x(:,k);
 x(:,k+1)=A*x(:,k)+B*u(k);
end

K1 = squeeze(K(1,1,:));
K2 = squeeze(K(1,2,:));

figure
subplot(3,2,1), plot(linspace(1,N+1,N+1),x(1,:)), title('state x1')
subplot(3,2,3), plot(linspace(1,N+1,N+1),x(2,:)), title('state x2')
subplot(3,2,5), plot(linspace(1,N,N),u(1,:)), title('action control u')
subplot(3,2,2), plot(linspace(1,N,N),K1), axis([1 N 0 1]), title('Gain K1')
subplot(3,2,4), plot(linspace(1,N,N),K2), axis([1 N 0 1]) ,title('Gain K2')

%We can check the theorem 3
J = 0.5*x(:,:,1)'*P(:,:,1)*x(:,1); %J=0.5·x'(1)·P(1)·x(1)

J=0;
for k=1:N
    J=J+0.5*x(:,k)'*Q*x(:,k)+0.5*u(k)*R*u(k);
end
J = J+0.5*x(:,N+1)'*S*x(:,N+1) % Definition of J


 %% Steady state
close all; clc

P=zeros(2,2);
Pnew=Q+A'*P*inv(eye(2)+B*inv(R)*B'*P)*A;
while sum(sum(abs(P-Pnew)))>0.0001
     P=Pnew;
     Pnew=Q+A'*P*inv(eye(2)+B*inv(R)*B'*P)*A;
end

Pss=dare(A,B,Q,R);
Kss=dlqr(A,B,Q,R);

%% Act1.4 Riccati.m Analytical approximate optimal solution

A=[1, 1; 1,0];  % system matrix
B=[1;0];        % control matrix
Q=eye(2);   % weight of states in obj function
S=Q;        % weight of final state in obj function
R=1;        % weight of control action in obj function
N=10;       % horizon

%Initialization
P=zeros(2,2,N+1);   % P matrix
K=zeros(1,2,N);     % gain
u=zeros(1,N);       % control action
x=zeros(2,N+1);     % states
x(:,1)=[1,1];       % initial conditions

% Solve Riccati equation with steady state approximation
Pss=dare(A,B,Q,R);
Kss=dlqr(A,B,Q,R)

% Calculus of u and x
for k=1:N
    u(k)=-Kss*x(:,k);
    x(:,k+1)=A*x(:,k)+B*u(1,k);
end

figure,
subplot(3,1,1); plot(x(1,:)), title('State x1 (angular speed)')
subplot(3,1,2); plot(x(2,:)), title('State x2 (position)')
subplot(3,1,3); plot(u), title('Control signal u (voltage)')

%% RICATTI METHOD (STEADY STATE SOLUTION) WITH LMI - Act.1d

clear;

A=[1, 1; 1,0];  % system matrix
B=[1;0];        % control matrix
Q=eye(2);       % weight of states in obj function
S=Q;            % weight of final state in obj function
R=1;            % weight of control action in obj function
N=10;           % horizon

% Solve Riccati equation with steady state approximation
I = eye(2);
H = eye(2);
Y = sdpvar(2,2);
W = sdpvar(1,2,'full');
gamma = sdpvar(1,1)

%Initialization
u=zeros(1,N); % control action
x=zeros(2,N+1); % states
x(:,1)=[1,1];

%Solving the optimization problem
constraints=[Y>=0];
constraints=[constraints, [gamma*I I;I Y]];
constraints=[constraints, [  -Y       Y*A'-transpose(W)*B'     Y*H'      transpose(W);
                           A*Y-B*W            -Y            zeros(2,2)   zeros(2,1);
                             H*Y           zeros(2,2)            -I      zeros(2,1);
                              W            zeros(1,2)       zeros(1,2)    -R^(-1)] <=0];
options = sdpsettings('solver', 'sedumi');
optimize(constraints,gamma,options) 

%Kss computation
Kss= value(W)*inv(value(Y));

%Calculus of u and x
for k=1:N
    u(k)=-Kss*x(:,k);
    x(:,k+1)=A*x(:,k)+B*u(1,k);
end

figure
subplot(3,1,1); plot(x(1,:)), title('State x1 (angular speed)')
subplot(3,1,2); plot(x(2,:)), title('State x2 (position)')
subplot(3,1,3); plot(u), title('Control signal u (voltage)')

%% NUMERICAL SOLUTION WITH CONSTRAINTS - Act.1e

clear;

A=[1, 1; 1,0]; 
B=[1;0];            % control matrix 
Q=eye(2);           % weight of states in obj function 
R=1;                % weight of control action in obj function 
N=10;               % horizon
nu = 1;             % number of inputs (voltage)
nx = 2;             % number of states (position and velocity)

%Initialization
u = sdpvar(repmat(nu,1,N),repmat(1,1,N));
x = sdpvar(repmat(nx,1,N+1),repmat(1,1,N+1));
x{1}=[1;1];         % initial conditions
constraints = [];
objective = 0;

% Objective function and constraints
for k = 1:N
    objective = objective + x{k}'*Q*x{k} + u{k}'*R*u{k};
    constraints = [constraints, x{k+1} == A*x{k} + B*u{k}];
    constraints = [constraints, u{k} >= -1.5];
    constraints = [constraints, u{k} <= +1.5];
end
options = sdpsettings('solver', 'quadprog');
optimize(constraints,objective,options);

xopt(:,1)=[1;1];

%Calculus of u and x 
for k=1:N 
    uopt(k)=value(u{k});
    xopt(:,k+1)=A*xopt(:,k)+B*uopt(k);
end 

figure
subplot(3,1,1); plot(xopt(1,:)), title('State x1 (angular speed)')
subplot(3,1,2); plot(xopt(2,:)), title('State x2 (position)')
subplot(3,1,3); plot(uopt), title('Control signal u (voltage)')

%% DYNAMIC PROGRAMMING - Act. 2
clear;

A=[1, 1; 1,0];      % system matrix
B=[1;0];            % control matrix
Q=eye(2);           % weight of states in obj function
S=Q;                % weight of final state in obj function
R=1;                % weight of control action in obj function
N=10;               % horizon

%Initialization
P=zeros(2,2,N+1);   % P matrix
K=zeros(1,2,N);     % gain
u=zeros(1,N);       % control action
x=zeros(2,1,N+1);   % states
x(:,1)=[1,1];       % initial conditions

P(:,:,N+1)=S;
[x,u,P,K]=dynamic_lqr(N,x,u,P,K,A,B,R,Q);
J_opt=0.5*x(:,:,1)'*P(:,:,1)*x(:,:,1)

for k=1:N
    u(k)=-K(:,:,k)*x(:,k);
    x(:,k+1)=A*x(:,k)+B*u(k);
end

figure
subplot(3,1,1); plot(x(1,:)), title('State x1 (angular speed)')
subplot(3,1,2); plot(x(2,:)), title('State x2 (position)')
subplot(3,1,3); plot(u), title('Control signal u (voltage)')

function [x,u,P,K]=dynamic_lqr(k,x,u,P,K,A,B,R,Q)
    N=10;
    if k==1
        x(:,:,k)=[1,1]; % initial conditions
        K(:,:,k)=inv(R+B'*P(:,:,k+1)*B)*B'*P(:,:,k+1)*A;
        P(:,:,k)=Q+A'*P(:,:,k+1)*inv(eye(2)+B*inv(R)*B'*P(:,:,k+1))*A;
        u(k)=-K(:,:,k)*x(:,:,k);
    else
        K(:,:,k)=inv(R+B'*P(:,:,k+1)*B)*B'*P(:,:,k+1)*A;
        P(:,:,k)=Q+A'*P(:,:,k+1)*inv(eye(2)+B*inv(R)*B'*P(:,:,k+1))*A;
    
        %Invoking the function for k-1
        [x,u,P,K]=dynamic_lqr(k-1,x,u,P,K,A,B,R,Q);
        x(:,:,k)=A*x(:,:,k-1)+B*u(N-1);
        u(k)=-K(:,:,k)*x(:,:,k);
    end
end
