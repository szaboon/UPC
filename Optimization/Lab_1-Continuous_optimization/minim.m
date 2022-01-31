function [x,histx,ns,val]=minim(f,seed,algor,tol,niter,a,Dx)
%
% [x,ns,histx,val]=minim(f,seed,algor,tol,niter,a,Dx)
%
% INPUTS
% f  = function to be minimized
% seed  = initial value  /default [0;0]
% algor = algorithm to be used
%             1.Proportional to the gradient
%             2.Steepest descent using second order approximation
%             3.Newton method
% tol   = stop criterium abs(gradf(f,x))<tol /default 0.001
% niter = iterations number /default 500
% a     = step size for algorithm 1 /default 0.1
% Dx    =(Dx(1),Dx(2),…]  vector of increments for gradient and hessian
%
%
% OUTPUTS
% x      = the minimum
% histx  = the historic sequence of x
% ns     = the number of steps
% val    = f(min)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%defaut values

if nargin < 7 Dx=[0.01,0.01]; %default increments
    if nargin < 6 a=0.1; %default step size
        if nargin < 5 niter=500; %default max #iterations
            if nargin < 4 tol=0.001; %default tolerance
                if nargin < 3 algor=3; %default algorithm=Newton
                    if nargin < 2 seed=[0;0]; %default initial point
                    end
                end
            end
        end
    end
end

% checks
if nargin<1 
    disp('minim: function to be minimized is mandatory')
    return
end


if size(seed,1)==1 
    seed=seed'; 
end   %a column vector is needed 



x=seed;                 % the first point is the seed
histx=[];               % sequence of point initialization
gx=gradf(f,x,Dx);       % calculate the gradient
ngx=norm(gx);           % and the norm
H = hesf(f,x,Dx);       % Hessian


%% Algorithms
switch algor
           
     case {1}       % gradient descent (step proportional to the gradient)
        i=1;
        while i<=niter && ngx>tol
            histx=[histx,x];
            x=x-a*gx;
            gx=gradf(f,x,Dx);
            ngx=norm(gx);
            i=i+1;           
        end
            
     case {2}       %steepest gradient descent with second order approx.
        i=1;
        while i<=niter && ngx>tol
            histx=[histx,x];
            b = (gx'*gx)/(gx'*H*gx);
            x=x-b*gx;
            gx=gradf(f,x,Dx);
            ngx=norm(gx);
            H = hesf(f,x,Dx);
            i=i+1;           
        end
        
     case {3}       %Newton method
        i=1;
        while i<=niter && ngx>tol
            histx=[histx,x];
            x=x-H^(-1)*gx;
            gx=gradf(f,x,Dx);
            ngx=norm(gx);
            H = hesf(f,x,Dx);
            i=i+1;           
        end
     otherwise
        disp('minim: Incorrect algorithm')
        return
end
histx=[histx,x];
histx=histx';
ns=i-1;  % number of steps
val=f(x);
end