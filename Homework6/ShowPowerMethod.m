function ShowPowerMethod()
% Illustrates the convergence of the power method...

% Generate a random symmetric A...
n = 100;
A = randn(n,n); A = A+A';
% Use eig to compute the dominant eigenvalue and eigenvector...
[Q,D] = eig(A);
[lambda,idx] = sort(abs(diag(D)),'descend');
q1 = Q(:,idx(1));
lambda1 = D(idx(1),idx(1));
lambda2 = D(idx(2),idx(2));
% Now apply itMax steps of the power method with a random starting vector..
v = randn(n,1); 
v = v/norm(v);
itMax = 10*n;
for k=1:itMax
    w = A*v;
    v = w/norm(w);
    mu = v'*A*v;
    errEig(k) = abs(lambda1-mu);
    % The sine of the angle between q1 and v...
    errVec(k) = sqrt(abs(1 - (q1'*v)^2)) + eps;   % Add eps to avoid log(0) below
end
subplot(2,1,1)
% The error in the kth iterate is about (|lambda2|/|lambda1|)^2k
semilogy(errEig)
title(sprintf('errEig     |lambda2|/lambda1| = %5.3f',abs(lambda2/lambda1)))
subplot(2,1,2)
% The error in the kth iterate is about (|lambda2|/|lambda1|)^k
semilogy(errVec)
title(sprintf('errVec     |lambda2|/lambda1| = %5.3f',abs(lambda2/lambda1)))
shg
