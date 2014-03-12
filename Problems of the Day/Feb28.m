function Feb28()

a = 5+2*rand(1);
b = 3+2*rand(1);

close all
% Intuition: The maximizing triangle must have a vertex at
% (a,0) or (-a,0) or (0,b) or (0,-b). Symmetry suggests that
% the maximizing triangle is isosceles.

% Let's choose x so that the triangle with vertices
%  (a,0), (x,b*sqrt(1-(x/a)^2)) and (x,b*sqrt(1-(x/a)^2)) has
% maximal area. The area of that triangle is (a-x)*b*sqrt(1-(x/a)^2).
[x1,Area1] = fminbnd(@(x) MyF1(x,a,b),-a,a);
Area1 = -Area1;
t = linspace(0,2*pi);
subplot(1,2,1)
plot(a*cos(t),b*sin(t));
axis equal
hold on
fill([a x1 x1],[0 b*sqrt(1-(x1/a)^2) -b*sqrt(1-(x1/a)^2) ],'r' )
title(sprintf('Max area = %5.3f',Area1),'fontsize',18)
hold off
shg

subplot(1,2,2)
% Let's choose y so that the triangle with vertices
%  (0,b), (a*sqrt(1-(y/b)^2),y) and (a*sqrt(1-(y/b)^2),y) has
% maximal area. The area of that triangle is (b-y)*a*sqrt(1-(y/b)^2).
[y1,Area2] = fminbnd(@(y) MyF2(y,a,b),-b,b);
Area2 = -Area2;
t = linspace(0,2*pi);
plot(a*cos(t),b*sin(t));
axis equal
hold on
fill([0 a*sqrt(1-(y1/b)^2) -a*sqrt(1-(y1/b)^2) ],[b y1 y1],'g' )
title(sprintf('Max area = %5.3f',Area2),'fontsize',18)
hold off
shg

% The problem has 4 solutions. 

function z = MyF1(x,a,b)
% Negative of the area of the triangle with vertices 
% (a,0), (x,b*sqrt(1-(x/a)^2)) and (x,b*sqrt(1-(x/a)^2)).
z = -(a-x)*b*sqrt(1-(x/a)^2);

function z = MyF2(y,a,b)
% Negative of the area of the triangle with vertices 
% (0,b), (a*sqrt(1-(y/b)^2),y) and (a*sqrt(1-(y/b)^2),y) 
z = -(b-y)*a*sqrt(1-(y/b)^2);