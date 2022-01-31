close all
clear all
mc=1.12;
mp=0.095;
L=0.36;
g=9.81;
Um=0.5;
DZu=0.4;
DZpv=3.6;
DZcp=6.8;
DZcv=0.08;
fp=0.0038;
J=0.0075;
l=0.0167903;
mu=l*(mc+mp);
Fs=2.75;
a=-l^2+J/(mc+mp);
M=22.304;
Fc=0.75;
FSD=2.7457;
FSU=2.7972;
FCU=0.8793;
FCD=0.2501;
Xc=2;
Yc=2;
FS=2;
FSul=2;
FSdl=-1;


%linearisation
A=[0 0 1 0;0 0 0 1;0 -l*mu*g/J -a*Fc/J -l*fp/J;0 -mu*g/J -l*Fc/J -fp/J]
B=[0;0;a/J;l/J];
C=[1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1];
D=[0;0;0;0];

%transfer function
[num,den]=ss2tf(A,B,C,D);

%Discretisation
A1=expm(A(2:4,2:4)*0.1);
B1=(A1-eye(3))*inv(A(2:4,2:4))*B(2:4);

%Observer
L=place(A',[1 0 0 0;0 1 0 0]',[-5,-5.1,-5.2,-5.3]);
L=L';

%%
sim('three_models_observer')


%simulation of the complete model
figure(1)

subplot(2,2,1)
plot(x(:,1),x(:,2))
xlabel('time [s]')
ylabel('x [m]')
title('complete model')
subplot(2,2,2)
plot(x1(:,1),theta(:,2))
xlabel('time [s]')
ylabel('theta [rad]')
title('complete model')
subplot(2,2,3)
plot(x(:,1),dx(:,2))
xlabel('time [s]')
ylabel('dx/dt [m/s]')
title('complete model')
subplot(2,2,4)
plot(x(:,1),dtheta(:,2))
xlabel('time [s]')
ylabel('dtheta/dt [rad/s]')
title('complete model')

%simulation of the non-linear model
figure(2)

subplot(2,2,1)
plot(x(:,1),x(:,2))
hold on
plot(x(:,1),x1(:,2),'r')
xlabel('time [s]')
ylabel('x [m]')
title('complete nl model')
subplot(2,2,2)
plot(x(:,1),theta(:,2))
hold on
plot(x(:,1),theta1(:,2),'r')
xlabel('time [s]')
ylabel('theta [rad]')
title('complete nl model')
subplot(2,2,3)
plot(x(:,1),dx(:,2))
hold on
plot(x(:,1),dx1(:,2),'r')
xlabel('time [s]')
ylabel('dx/dt [m/s]')
title('complete nl model')
subplot(2,2,4)
plot(x(:,1),dtheta(:,2))
hold on
plot(x(:,1),dtheta1(:,2),'r')
xlabel('time [s]')
ylabel('dtheta/dt [rad/s]')
title('complete nl model')

%simulation of the linear model
figure(3)

subplot(2,2,1)
plot(x(:,1),x(:,2))
hold on
plot(x(:,1),x2(:,2),'r')
xlabel('time [s]')
ylabel('x [m]')
title('complete l model')
subplot(2,2,2)
plot(x(:,1),theta(:,2))
hold on
plot(x(:,1),theta2(:,2),'r')
xlabel('time [s]')
ylabel('theta [rad]')
title('complete l model')
subplot(2,2,3)
plot(x(:,1),dx(:,2))
hold on
plot(x(:,1),dx2(:,2),'r')
xlabel('time [s]')
ylabel('dx/dt [m/s]')
title('complete l model')
subplot(2,2,4)
plot(x(:,1),dtheta(:,2))
hold on
plot(x(:,1),dtheta2(:,2),'r')
xlabel('time [s]')
ylabel('dtheta/dt [rad/s]')
title('complete l model')

%simulation of the transfer function
figure(4)

subplot(2,2,1)
plot(x(:,1),x(:,2))
hold on
plot(x(:,1),x3(:,2),'r')
xlabel('time [s]')
ylabel('x [m]')
title('complete tf model')
subplot(2,2,2)
plot(x(:,1),theta(:,2))
hold on
plot(x(:,1),theta3(:,2),'r')
xlabel('time [s]')
ylabel('theta [rad]')
title('complete tf model')
subplot(2,2,3)
plot(x(:,1),dx(:,2))
hold on
plot(x(:,1),dx3(:,2),'r')
xlabel('time [s]')
ylabel('dx/dt [m/s]')
title('complete tf model')
subplot(2,2,4)
plot(x(:,1),dtheta(:,2))
hold on
plot(x(:,1),dtheta3(:,2),'r')
xlabel('time [s]')
ylabel('dtheta/dt [rad/s]')
title('complete tf model')
%simulation discrete
figure(5)

subplot(2,2,1)
plot(x(:,1),x(:,2))
hold on
plot(x4(:,1),x4(:,2),'r')
xlabel('time [s]')
ylabel('x [m]')
title('complete disc model')
subplot(2,2,2)
plot(x(:,1),theta(:,2))
hold on
plot(x4(:,1),theta4(:,2),'r')
xlabel('time [s]')
ylabel('theta [rad]')
title('complete  disc model')
subplot(2,2,3)
plot(x(:,1),dx(:,2))
hold on
plot(x4(:,1),dx4(:,2),'r')
xlabel('time [s]')
ylabel('dx/dt [m/s]')
title('complete  disc model')
subplot(2,2,4)
plot(x(:,1),dtheta(:,2))
hold on
plot(x4(:,1),dtheta4(:,2),'r')
xlabel('time [s]')
ylabel('dtheta/dt [rad/s]')
title('complete  disc model')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sim('Observer')

figure(6)

subplot(2,2,1)
plot(x(:,1),x(:,2))
hold on
plot(x(:,1),x6(:,2),'r')
xlabel('time [s]')
ylabel('x [m]')
title('complete obs model')
subplot(2,2,2)
plot(x(:,1),theta(:,2))
hold on
plot(x(:,1),theta6(:,2),'r')
xlabel('time [s]')
ylabel('theta [rad]')
title('complete obs model')
subplot(2,2,3)
plot(x(:,1),dx(:,2))
hold on
plot(x(:,1),dx6(:,2),'r')
xlabel('time [s]')
ylabel('dx/dt [m/s]')
title('complete obs model')
subplot(2,2,4)
plot(x(:,1),dtheta(:,2))
hold on
plot(x(:,1),dtheta6(:,2),'r')
xlabel('time [s]')
ylabel('dtheta/dt [rad/s]')
title('complete obs model')

%% Discrete observer

A1=expm(A(2:4,2:4)*0.01);
B1=(A1-eye(3))*inv(A(2:4,2:4))*B(2:4);


% Pole placement
% We Choose:
c(1) = 0.3;  % First eigenvalue
range = 3; % Range of poles - The larger the range is and the more negative the fisrt eigenvalue is
                            % the faster the regulation will be.
% Is calculated:
n = 3;             % Matrix size
c(n) = c(1)*range;          % Maximal absolute damping 
k = nthroot(c(n)/c(1),n-1); % Damping coeficient

% Calculation of the remaining eigenvalues
for i=1:n-2
    c(i+1) = k^i*c(1);
end
p = c  % Poles

% Checking controlability and observability
Mc = ctrb(A,B);   % Controlability matrix
Mo = obsv(A,C);   % Observability matrix

if rank(Mc) == size(A,1)       % System's controlability
    disp("System is controlable")
else
    disp("System is not controlable")
end
if rank(Mo) == size(A,2)       % System's observability
    disp("System is observable")
else
    disp("System is not observable")
end 

L1=place(A1',[1 0 0]',p);
L1=L1';
sim('modelcomplet.mdl')

figure(7)

% subplot(2,2,1)
% plot(x(:,1),x(:,2))
% hold on
% plot(x(:,1),x7(:,2),'r')
% xlabel('time [s]')
% ylabel('x [m]')
% title('complete obs model')
% subplot(2,2,2)
% plot(x(:,1),theta(:,2))
% hold on
% plot(x(:,1),theta7(:,2),'r')
% xlabel('time [s]')
% ylabel('theta [rad]')
% title('complete obs model')
% subplot(2,2,3)
% plot(x(:,1),dx(:,2))
% hold on
% plot(x(:,1),dx7(:,2),'r')
% xlabel('time [s]')
% ylabel('dx/dt [m/s]')
% title('complete obs model')
subplot(2,2,1)
plot(x(:,1),x(:,2))
% hold on
% plot(x(:,1),x6(:,2),'r')
xlabel('time [s]')
ylabel('x [m]')
title('complete obs model')
subplot(2,2,2)
plot(x(:,1),theta(:,2))
hold on
plot(x(:,1),x7(:,2),'r')
xlabel('time [s]')
ylabel('theta [rad]')
title('complete obs model')
subplot(2,2,3)
plot(x(:,1),dx(:,2))
hold on
plot(x(:,1),theta7(:,2),'r')
xlabel('time [s]')
ylabel('dx/dt [m/s]')
title('complete obs model')
subplot(2,2,4)
plot(x(:,1),dtheta(:,2))
hold on
plot(x(:,1),dx7(:,2),'r')
xlabel('time [s]')
ylabel('dtheta/dt [rad/s]')
title('complete obs model')