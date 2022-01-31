function dibujaEnsayo(exp)
%
% dibujaEnsayo(exp)
%
% 'exp' tiene 7 columnas.
%
%   col 1: tiempo en segundos
%   col 2: posición x en metros
%   col 3: velocidad x en metros/segundos
%   col 4: posición y en metros
%   col 5: velocidad y en metros/segundos
%   col 6: RefPitch entre -1 y 1
%   col 7: RefRoll entre -1 y 1
%


figure
subplot(6,1,1)
plot(exp(:,1),exp(:,2))
title('x')
subplot(6,1,2)
plot(exp(:,1),exp(:,3)),
% hold on
% plot(exp(:,1),exp(:,6))
title('vx')
subplot(6,1,3)
plot(exp(:,1),exp(:,4))
title('y')
subplot(6,1,4)
plot(exp(:,1),exp(:,5))
title('vy')
subplot(6,1,5)
plot(exp(:,1),exp(:,6))
title('RefPitch')
subplot(6,1,6)
plot(exp(:,1),exp(:,7))
title('RefRoll')
xlabel('sec')

figure
plot(exp(:,2),exp(:,4))
title('Trayectoria xy')