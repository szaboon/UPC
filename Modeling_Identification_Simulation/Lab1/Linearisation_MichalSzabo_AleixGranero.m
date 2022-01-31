%% parameters of the four_tank_model are defined
close all;

g=981; %cm/s2
a1=0.071; %cm2
A1=28; %cm2
k1=3.33; %cm3/Vs
gamma1=0.7;
Ts=1;

a2=0.071; %cm2
A2=28; %cm2
k2=3.33; %cm3/Vs
gamma2=0.7;

a3=0.071; %cm2
A3=28; %cm2


a4=0.071; %cm2
A4=28; %cm2

v10=2;
v11=2.2;
v20=2;
v22=1.8;

% changing inputs v10 and v20 without changing h10,h20,h30,h40 defined at eq 
% v10=2.4;
% v11=2.2;
% v20=1.6;
% v22=1.8;

t1=200;
t2=400;

%% Attention!  h10 h20 h30 h40 have to be defined (Equilibrium point)
% Equlibiriuum point

h30 = 1/(2*g)*((1-gamma2)*k2*v20/a3)^2
h40 = 1/(2*g)*((1-gamma1)*k2*v10/a4)^2
h10 = 1/(2*g)*(a3/a1 * sqrt(2*g*h30)+gamma1*k1/a1*v10)^2
h20 = 1/(2*g)*(a4/a2 * sqrt(2*g*h40)+gamma2*k1/a2*v20)^2

% State-Space model

K1 = -a1/A1*g/sqrt(2*g*h10);
K2 = -a2/A2*g/sqrt(2*g*h20);
K3 = -a3/A1*g/sqrt(2*g*h30);
K4 = -a4/A2*g/sqrt(2*g*h40);

J1 = gamma1*k1/A1;
J2 = gamma2*k2/A2;
J3 = (1-gamma2)*k2/A3;
J4 = (1-gamma1)*k1/A4;

A = [K1   0 -K3   0; 
      0  K2   0 -K4;
      0   0  K3   0;
      0   0   0  K4]

B = [J2 0;
     0 J2;
     0 J3;
     J4 0]

C = eye(4);
D = zeros(4,2);

%% Compute maximal error

figure
hold on
plot(abs(h1-h1_lin));
plot(abs(h2-h2_lin));
plot(abs(h3-h3_lin));
plot(abs(h4-h4_lin));
grid
legend("h1", "h2", "h3", "h4")
title("Error")

error_h1 = max(abs(h1-h1_lin));
error_h2 = max(abs(h2-h2_lin));
error_h3 = max(abs(h3-h3_lin));
error_h4 = max(abs(h4-h4_lin));

ERROR = [error_h1,error_h2,error_h3,error_h4]
