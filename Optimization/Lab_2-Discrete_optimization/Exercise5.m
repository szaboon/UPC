%% Exercise 5
close all; clc; clear;

N = 9;
q = 4; r = 2; qN = 8;
a = 2; b = 1;
p = zeros(1,N); p(N)=qN;
K=zeros(1,N-1);
x=zeros(1,N-1); x(1)=10;
u=zeros(1,N-1);
for k=(N-1):-1:1
    p(k)=q+a^2*p(k+1)-a^2*b^2*p(k+1)^2*(r+b^2*p(k+1))^-1;
    K(k)=(r+b^2*p(k+1))^-1*a*b*p(k+1); 
end
for k=1:N-1
    u(k)=-K(k)*x(k);
    x(k+1)=a*x(k)+b*u(k);
end
x
u
plot(1:(N-1),u,'o-b',1:N,x,'r-o')
legend('control','state')
grid on
xlim([0,N])
%%
N = 9;
qN = 5;
q = 2;
r = 2;
a = 2;
b = 1;
p = zeros(1,N);
p(N)=qN;
K=zeros(1,N-1);
x=zeros(1,N-1);
x(1)=10;
u=zeros(1,N-1);
for k=(N-1):-1:1
    p(k)=q+a^2*p(k+1)-a^2*b^2*p(k+1)^2*(r+b^2*p(k+1))^-1;
    K(k)=(r+b^2*p(k+1))^-1*a*b*p(k+1); 
end
for k=1:N-1
    u(k)=-K(k)*x(k);
    x(k+1)=a*x(k)+b*u(k);
end
x
u
hold on
plot(1:(N-1),u,'o-b',1:N,x,'r-o')
legend('control','state')
grid on
xlim([0,N])