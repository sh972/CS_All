  function E = FitConicLS(x,y)
% x and y are column N-vectors and E is an ellipse. 
% Let Ax^2 + Bxy + Cy^2 + Dx + Ey + F = 0 be the conic representation of E
% with A = 1. If
%      f(u,v) =  u^2 + Buv + Cv^2 + Du + Ev + F 
% then B,C,D,E, and F are chosen so that
%      f(x(1),y(1))^2 + ... + f(x(N),y(N))^2
% is minimum.

% Set up the LS problem min norm(Ms-r,2)

N = length(x);
Mat = [x.*y y.^2  x  y  ones(N,1)];
r = -x.^2;
z = Mat\r;
% The conic coefficients...
A = 1;
B = z(1);
C = z(2);
D = z(3);
E = z(4);
F = z(5);
% Determine the parametric representation of E...
M = [A B/2;B/2 C];
[Q,Lambda] = schur(M);
r = (A-C)/B;   % cot(2tau)
tau = acot(r)/2;
if A>C
    tau = tau+pi/2;
end
tau = mod(tau,2*pi);
z = M\[-D/2;-E/2];
h = z(1);
k = z(2);
m = -det([F D/2 E/2;D/2 A B/2; E/2 B/2 C])/det(M);
a = sqrt(m/Lambda(1,1));
b = sqrt(m/Lambda(2,2));
% Build the structure...
E = MakeEllipse(a,b,h,k,tau*180/pi);