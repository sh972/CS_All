function [xStar,yStar,ThetaStar] = Sideline(a,b,d,w)
% a, b, d, w are positive real numbers with the property that the goalpost locations
% P1 = (-d,-w/2) and P2 = (-d,w/2) are inside the ellipse (x/a)^2 + (y/b)^2 = 1.
% Q = (xStar,yStar) is a point on the ellipse with the property that 
% angle P1-Q-P2 is maximized subject to the constraint that a player standing at Q
% is looking into the goal. ThetaStar is the maximum angle in degrees.


% Begin constructing a function of angle by using the variable t:

% We express x and y in terms of a, b, and t.
x = @(t) a*cos(t);
y = @(t) b*sin(t);

% Function dx will return the difference in x between the point at t and a
% point with x-coordinate d.
dx = @(d, t) abs(x(t) - d);

% Function dy will return the difference in y between the point at t and a
% point with y-coordinate w.
dy = @(w, t) abs(y(t) - w);

% xPost is the x coordinate of both posts.
% yPost1 is the y coordinate of the top post.
% yPost2 is the y coordinate of the bottom post.
xPost = -d;
yPost1 = w/2;
yPost2 = -w/2;

% Function theta calculates the angle from the point at t to a point (d, w)
theta = @(d, w, t) atan(dx(d, t)/dy(w, t));

% Function Dtheta calculates the angle (Post1, t, Post2).
Dtheta = @(t) abs(theta(xPost, yPost1, t) - theta(xPost, yPost2, t));

% Function negtheta negates Dtheta.
negtheta = @(t) -Dtheta(t);

% To find the greatest value of Dtheta, we find the least value of
% negtheta.
t = -fminbnd(negtheta, 0, 2*pi);

% xStar and yStar will be the x and y values at t
% ThetaStar will be Dtheta(t)
xStar = x(t)
yStar = y(t)
ThetaStar = Dtheta(t)