  function ShowTransits()
% Simulates the motion of the 4 inner planets and transits as viewed
% from Mars.
% Set up a black display area...
close all
M = 280;
fill([-M M M -M],[-M -M M  M],'k')
axis equal off
hold on
% Display the Sun...
r = 15; theta = linspace(0,2*pi); fill(r*cos(theta),r*sin(theta),'y')
% Display the orbits of the 4 inner planets...
tau = linspace(0,700,601);
Mercury = Location(tau,1);
Venus = Location(tau,2);
Earth = Location(tau,3);
Mars = Location(tau,4);
plot(Mercury.x,Mercury.y,'w')
plot(Venus.x,Venus.y,'w')
plot(Earth.x,Earth.y,'w')
plot(Mars.x,Mars.y,'w')
% Display planet location for the next T days...
T = 2000;
for t=1:T
    % Compute the locations...
    Mercury = Location(t,1);
    Venus = Location(t,2);
    Earth = Location(t,3);
    Mars = Location(t,4);
    % The two tangent points as viewed from Mars...
    [L,R] = TP(Mars,r);
    % The Left and Right tangent lines...
    hL = plot([Mars.x L.x],[Mars.y L.y],'c');
    hR = plot([Mars.x R.x],[Mars.y R.y],'m');
    % The four planets...
    h1 = plot(Mercury.x,Mercury.y,'.w','Markersize',20);
    h2 = plot(Venus.x,Venus.y,'.w','Markersize',20);
    h3 = plot(Earth.x,Earth.y,'.w','Markersize',20);
    h4 = plot(Mars.x,Mars.y,'.r','Markersize',20);
    pause(.03)
    shg
    delete(hL,hR,h1,h2,h3,h4)
end

  function [L,R] = TP(E,r)
% Let C be the circle x^2+y^2 = r^2.
% E is a point outside of C
% L is a point on C with the property that the line through E and L is
% tangent to C.
% R is a point on C with the property that the line through E and R is
% tangent to C.
% To an observer at E, L is to the left of R.

d = sqrt(E.x^2+E.y^2); s = r/d; c = sqrt(1-s^2);
alfa = -(c*E.x-s*E.y); beta = -(+s*E.x+c*E.y);
f = sqrt(d^2-r^2)/sqrt(alfa^2+beta^2);
L = MakePoint(f*alfa+E.x,f*beta+E.y);
alfa = -(c*E.x+s*E.y); beta = -(-s*E.x+c*E.y);
f = sqrt(d^2-r^2)/sqrt(alfa^2+beta^2);
R = MakePoint(f*alfa+E.x,f*beta+E.y);

      
   function E = Location(t,k)
 % E is a length-n structure array with the property that
 % planet k is located at (E.x(i),E.y(i)) at time t(i), i=1:n.
 % (Time is in earth days.) 
 % If k=1, then Mercury's location is specified.
 % If k=2, then Venus's   location is specified.
 % If k=3, then Earth's   location is specified.
 % If k=4, then Mars's    location is specified.
 
 % Orbit parameters of the inner 4 planets...
 P = [  46.0032; 107.4819; 147.1053; 206.6782];
 A = [  69.8200; 108.9441; 152.1053; 249.2205];
 phi = [ 77.45645; 131.53298; 102.94719; 336.04084];
 Y   = [  87.968; 224.695; 365.242; 686.930];
 x = (P(k) - A(k))/2 + ((P(k)+A(k))/2)*cos(t*2*pi/Y(k));
 y = sqrt(P(k)*A(k))*sin(t*2*pi/Y(k));
 c = cos(phi(k)*pi/180);
 s = sin(phi(k)*pi/180);
 E = MakePoint(c*x-s*y,s*x+c*y);
 
function P = MakePoint(x,y)
% P is a 2-field structure with x assigned to P.x and y assigned to P.y.
P = struct('x',x,'y',y);

