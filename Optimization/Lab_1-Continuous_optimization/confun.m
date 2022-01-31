function [c, ceq] = confun(x)

% Linear equality constraints
% c = HERE, NONLINEAR INEQUALITY CONSTRAINTS;
c=[];

% Non-linear equality constraints
%ceq = HERE, NONLINEAR EQUALITY CONSTRAINTS;
ceq=[2*x(1)^4+x(2)^4+6*x(1)*x(2)-55
    (x(3)-1)^2+(x(4)^2-5)^2-x(3)*x(4)-40];

end