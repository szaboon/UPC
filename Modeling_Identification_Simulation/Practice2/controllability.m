A = [-4 0 0 0;
      0 -4 0 0;
      1 1 -4 0;
      0 0 2 -1];

B = [2 0 0 0;
     1 1 0 0;
     0 0 1 0;
     0 0 0 0];
c = [0 0 0 1];
D = [0 0 0 1];

% Controllable
P4 = [B,A*B,A^2*B,A^3*B];
rank(P4)

%%
% Observable
Q = [C',A'*C',(A^2)'*C',(A^3)'*C'];
rank(Q)

% Controlability for inputs
% u1,u2,u3
P3 = [B,A*B,A^2*B];
rank(P3)

% u1,u2
P2 = [B,A*B];
rank(P2)

% u1
P1 = [B];
rank(P1)

% u2
P_2 = [A*B];
rank(P1)

% u1,u3
P_13 = [B,A^2*B];
rank(P1)

