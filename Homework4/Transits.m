function [StartTime,Duration] = Transits(i,j,T)
% Period in days
Y = [87.968 224.695 365.242 686.930];

% Ti is the initial time 
% Tc is the time it takes for i to make half a revolution relative to j 
% (which is the same as relative to j's left tangent line). 
% Assumes approximately constant angular velocity
Ti = 0;
Tc = (Y(i).*Y(j)./(Y(j) - Y(i)))./2;

% If angle isn't positive, we ignore the 0 that fzero finds in the while
% loop. 
% The variable positive_angle alternates between True and False.
positive_angle = asin(FindSinL(Ti,i,j)) > 0;

p = 1;
StartTime = zeros(0,1);
Duration = zeros(0,1);
while Ti <= T
    if positive_angle
        start = fzero(@(t) FindSinL(t,i,j), [Ti (Ti + Tc)]);
        endtime = fzero(@(t) FindSinR(t,i,j), [start (start + .5)]);
        StartTime(p,1) = start;
        Duration(p,1) = (endtime - start).*24.*60;
        p = p + 1;
    end
    Ti = Ti + Tc;
    positive_angle = ~positive_angle;
end

% FindSin finds angle between the planets and the tangent point on the sun
% of the outer planet, L for left tangent points, and R for right.
function sin = FindSinL(t,i,j)
r = .6955;
A = Location(t,i);
B = Location(t,j);
[L, R] = TP(B,r);
v2 = [B.x - L.x; B.y - L.y];
v1 = [A.x - L.x; A.y - L.y];
sin = (v1(1).*v2(2) - v1(2).*v2(1))./(norm(v1).*norm(v2));

function sin = FindSinR(t,i,j)
r = .6955;
A = Location(t,i);
B = Location(t,j);
[L, R] = TP(B,r);
v2 = [B.x - R.x; B.y - R.y];
v1 = [A.x - R.x; A.y - R.y];
sin = (v1(1).*v2(2) - v1(2).*v2(1))./(norm(v1).*norm(v2));


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