  function ShowBigEVec()
% Checks out BigEVec
clc
disp('  alpha     ||Uv - v ||      its')
disp('------------------------------------')
tol = .000001;
itMax = 1000;
n = 100;
N = 10;
for k=1:N-1
   alpha = (k/N)*pi;
   U = MakeU(n,alpha);
   [v,its] = BigEVec(U,alpha,tol,itMax);
   errv = norm(U*v - v);
   fprintf('%10.6f   %10.3e    %4d\n',alpha,errv,its)
end

  function U = MakeU(n,alpha)
% U is  a random nxn alpha-orthogonal matrix.
m = floor((n-1)/2);
tau = [alpha ; alpha+(pi-alpha)*rand(m-1,1)];
c = cos(tau);   
s = sin(tau);
% Construct a random block diagonal alpha-orthogonal matrix...
D = zeros(n,n);
D(1,1) = 1;
for k=1:m
    D(2*k:2*k+1,2*k:2*k+1) = [c(k) s(k); -s(k) c(k)]; 
end
if rem(n,2)==0
    D(n,n) = -1;
end
% Now perform a random orthogonal similarity transformation...
[Q,R] = qr(randn(n,n));
U = Q*D*Q';