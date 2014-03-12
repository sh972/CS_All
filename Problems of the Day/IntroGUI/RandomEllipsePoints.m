  function [x,y] = RandomEllipsePoints(N,noise)
% Generates N random points that are approximately on a randomly
% generated ellipse. The value  of noise determines the departure
% of the points from the ellipse

% Generate the ellipse with center (0,0).
% The two semiaxes....
a = 1.0 + 3.0*rand();
b = 0.5 + 1.0*rand();
% The tilt...
tau = 2*pi*rand();
% Determine the N points that are approximately on the untilted ellipse...
t = 2*pi*rand(N,1);
x0 = a*cos(t)+noise*randn(N,1);
y0 = b*sin(t)+noise*randn(N,1);
% Now rotate then clockwise tau radians...
M = [x0 y0]*[cos(tau) sin(tau); -sin(tau) cos(tau)];
x = M(:,1);
y = M(:,2);



