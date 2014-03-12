  function DisplayEllipse(E,c)
% E is an ellipse and c is one of 'k', 'w', 'r', 'g', 'b', 'c', 'm', 'y'.
% Assume that hold is on.
% Displays E in color c in the current window
% x1 and y1 are points on the untilted ellipse...
m = 200;
t = linspace(0,2*pi,m)';
x1 = E.a*cos(t);
y1 = E.b*sin(t);
% Now rotate them...
tau = E.tau*pi/180;
x = zeros(m,1);
y = zeros(m,1);
for i=1:m
    x(i) = E.h + x1(i)*cos(tau) - y1(i)*sin(tau);
    y(i) = E.k + x1(i)*sin(tau) + y1(i)*cos(tau);
end
% Display together with the two focii
plot(x,y,c)
plot(E.F1x,E.F1y,['.' c],'Markersize',25)
plot(E.F2x,E.F2y,['.' c],'Markersize',25)