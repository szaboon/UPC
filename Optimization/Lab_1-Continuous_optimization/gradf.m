function z=gradf(f,x,Dx)
% Calculating gradient
    z = [(f([x(1)+Dx(1)/2,x(2)])-f([x(1)-Dx(1)/2,x(2)]))/Dx(1) 
         (f([x(1),x(2)+Dx(2)/2])-f([x(1),x(2)-Dx(2)/2]))/Dx(2)];
end