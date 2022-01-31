
N = 10
u(1) = 1
e(1) = 0
y(1) = 0
t0 = 0

for t=2:N+1
    u(t) = 10*(t-t0);
    e(t) = randn(1);
    y(t) = 0.8*y(t-1)+0.7*u(t-1)+e(t)+0.5*e(t-1);
    t0 = t;
    e0 = e;
    time(t) = t-1; 
end

%%

%%
for i = 1:length(y)
    v(i) = (y(i)-max(y))^2
end

S = sqrt((sum(v)^2)/N-1)