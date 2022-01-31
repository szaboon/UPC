function H=hesf(f,x,Dx)

% Calculating Hessian
f1=f([x(1)-Dx(1),x(2)]); 
f2=f([x(1)-Dx(1)/2,x(2)+Dx(2)/2]); 
f3=f([x(1)-Dx(1)/2,x(2)-Dx(2)/2]);
f4=f([x(1),x(2)+Dx(2)]); 
f5=f([x(1),x(2)]) ; 
f6=f([x(1),x(2)-Dx(2)]);
f7=f([x(1)+Dx(1)/2,x(2)+Dx(2)/2]); 
f8=f([x(1)+Dx(1)/2,x(2)-Dx(1)/2]); 
f9=f([x(1)+Dx(1),x(2)]);

H=[(f9-2*f5+f1)/Dx(1)^2,    (f7-f2-f8+f3)/(Dx(1)*Dx(2));
   (f7-f2-f8+f3)/(Dx(1)*Dx(2)),   (f4-2*f5+f6)/Dx(2)^2];
end