  function ShowEig()
% Schur Decomposition for Symmetric Matrices
% If A is symmetric then all its eigenvalues are real and there
% is an orthonormal basis of eigenvectors. In other words,
% there is an orthogonal matrix V so that V'*A*V = D is diagonal.
% Comparing columns in AV = VD we see that
%
%           AV(:,k) = D(k,k)*V(:,k)
%
% so V(:,k) is a unit 2-norm eigenvector associated with the eigenvalue
% D(k,k).

% A small example...
n = 6;
A = randn(n,n); A = A+ A';
clc
format short

disp('[V,D] = eig(A) if you want eigenvectors and eigenvalues...')
[V,D] = eig(A)

disp('d = eig(A) if you want just the eigenvalues...')
d = eig(A)

disp('Notice that the eigenvalues are ordered from most')
disp('negative to most positive.')


% How long does eig(A) take to execute?
% A big example...
n = 1000;
A = randn(n,n); A = A+A';
% Eigenvalues and eigenvectors...
tic
[V,D] = eig(A);
tBoth = toc;
% Just eigenvalues...
tic 
d = eig(A);
tJust = toc;
% Compare with Cholesky
IamPosDef = A + 2*max(abs(d))*eye(n,n);    % Why?
tic
G = chol(IamPosDef);
tChol = toc;
fprintf('\nBenchmark eig for both eigs and vecs, just eigs, and then compare to chol...\n')

fprintf('\nn = %1d\ntBoth = %5.3f\ntJust = %5.3f\ntChol = %5.3f\n',n,tBoth,tJust,tChol)


