function s = eoptdis(N)

% Initial values
x0=[];
for i=1:N
    a=0.5*rand(1);b=0.5*rand(1);c=sqrt(1-a^2-b^2);
    x0=[x0,a,b,c];
end

opts = optimoptions('fmincon','display','none');
[x,fval] = fmincon(@(x)f(x,N),x0,[],[],[],[],[],[],@(x)confun1(x,N),opts);

% Matrix of electron locations
P=[];
for i=0:(N-1)
    P=[P;[x(3*i+1),x(3*i+2),x(3*i+3)]];
end

% Matrix of distances between electrons
M = zeros(N);
for i=1:N
    for j=1:N
        M(i,j)=sqrt((P(i,:)-P(j,:))*(P(i,:)-P(j,:))');
    end
end

% Ploting sphere
[X,Y,Z] = sphere;  % Initializing sphere coordinates
r_sphere = sqrt(P(1,1)^2+P(1,2)^2+P(1,3)^2);  % Sphere radius
%   [x y z]
a = [0 0 0];
s1 = surf(X*r_sphere+a(1),Y*r_sphere+a(2),Z*r_sphere+a(3), ...
    'FaceColor','c', ...
    'FaceAlpha',0.3, ...
    'EdgeColor','none');
hold on
axis equal

% Ploting electrons
r = 0.1; % electron radius
for i=1:N
    se(i)=surf(X*r+P(i,1),Y*r+P(i,2),Z*r+P(i,3),'FaceColor','r','EdgeColor','none');
end
daspect([1 1 1])
view(30,20)

% Ploting conections between electrons
x=P(:,1);
y=P(:,2);
z=P(:,3);
DT = delaunayTriangulation(x,y,z);
tetramesh(DT,'FaceColor','none')
title(['Optimal Distribution of ', num2str(N), ' electrons'])
hold off

end
