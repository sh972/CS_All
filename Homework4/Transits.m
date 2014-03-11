function [StartTime,Duration] = Transits(i,j,T)

% Period in days
Y = [  87.968; 224.695; 365.242; 686.930];
T1 = Y(i);
T2 = Y(j);
Ti = 0;
p = 1;
TIME = T1*T2/(T2-T1)
while Ti <= T
    a = angleBtwnOrigin(i,j,Ti)
    int1 = T1*T2/(T2-T1)*a/pi
    start = fzero(@(t) lineupL(i,j,t), [Ti (Ti + int1)])
    if start > T
        break
    end
    b = angleBtwnOrigin(i,j,start)
    int2 = T1*T2/(T2-T1)*b/pi
    endtime = fzero(@(t) lineupR(i,j,t), [start (start + int2)])
    StartTime(p) = start;
    Duration(p) = endtime - start;
    Ti = Ti + int1;
    p = p+1;
end
end

function angle = AngleFromOrigin(x)
if x(1) > 0
    angle = atan(x(2)/x(1));
else 
    angle = pi + atan(x(2)/x(1));
end
if angle < 0
    angle = angle + 2*pi;
end
end

function angle = anglebtwn(x,y)
angle = AngleFromOrigin(y)-AngleFromOrigin(x);
end

function angle = angleBtwnOrigin(i,j,t)
A = Location(t,i);
x = [A.x A.y];
B = Location(t,j);
y = [B.x B.y];
angle = anglebtwn(x,y);
if angle < 0
    angle = angle + 2*pi;
end
end

function angle = lineupL(i,j,t)
A = Location(t,i);
x = [A.x A.y];
B = Location(t,j);
y = [B.x B.y];
[L,R] = TP(B,0.655);
l = [L.x L.y];
angle = anglebtwn(x-l, y-l);
end

function angle = lineupR(i,j,t)
A = Location(t,i);
x = [A.x A.y];
B = Location(t,j);
y = [B.x B.y];
[L,R] = TP(B,0.655);
r = [R.x R.y];
angle = anglebtwn(x-r, y-r);
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
  end

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
end
 
function P = MakePoint(x,y)
% P is a 2-field structure with x assigned to P.x and y assigned to P.y.
P = struct('x',x,'y',y);
end