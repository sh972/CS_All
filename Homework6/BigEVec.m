function [v,its] = BigEVec(U,alpha,tol,itMax)
% 0 < alpha <= pi
% U is n-by-n and alpha-orthogonal
% tol is a positive real number > the unit roundoff
% itMax is an upper bound on the number of iterations.
% v is a unit 2-norm n-vector that satisfies norm(Uv-v,2)<= tol and is
%   computed via the power method.
% its is the number of required iterations. If its > itMax then
% norm(Uv - v) may not be less than tol.

n = size(U, 1);

% l1 is the magnitude of lambda1, l2 is the magnitude of lambda2, and bound
% is the upper bound of |l2|/|l1| independent of mu.
% l1 = @(mu) 1+ mu;
% l2 = @(mu) sqrt(mu^2 +1 + 2*mu*cos(alpha));
% bound = @(mu) l2(mu)./l1(mu);

% We would calculate the optimal mu by:
% mu = fminbnd(@(mu) bound(mu), .8, 1.2)
% but mu always ends up as 1. 
mu = 1;
A = U + mu * eye(n, n);

v = randn(n,1);
v = v/norm(v);
its = 0;


while (norm(U*v - v) > tol) && (its ~= itMax)
    its = its + 1;
    w = A*v;
    v = w/norm(w);
end