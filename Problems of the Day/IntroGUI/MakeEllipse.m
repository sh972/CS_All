  function E = MakeEllipse(a,b,h,k,tau)
% E is an ellipse structure where
%    E.a = a is the semi-major axis
%    E.b = b is the semi-minor axis
%    E.h = h is the x-coordinate of the center
%    E.k = k is the y-coordinate of the center
%    E.tau = tau is the tilt angle (degrees)
%    E.F1x and E.F1y specify the xy coordinates of focus F1
%    E.F2x and E.F2y specify the xy coordinates of focus F2
%    E.s is the string length

% Determine the two foci...
c = sqrt(a^2-b^2);
F1x = h-cos(pi*tau/180)*c;
F1y = k-sin(pi*tau/180)*c;
F2x = h+cos(pi*tau/180)*c;
F2y = k+sin(pi*tau/180)*c;
% and the string length...
s = 2*a;
% Form the structure...
E = struct('a',a,'b',b,'h',h,'k',k,'tau',tau,'F1x',F1x,'F1y',F1y,'F2x',F2x,'F2y',F2y,'s',s);