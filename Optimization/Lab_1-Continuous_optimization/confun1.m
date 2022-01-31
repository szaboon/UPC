function [c, ceq] = confun1(x,N)
    % Nonlinear inequality constraints
    c = [];
    % Nonlinear equality constraints
    ceq=[];
    for (i=0:(N-1))
        ceq = [ceq; x(3*i+1)^2+x(3*i+2)^2+x(3*i+3)^2-1];
    end
end