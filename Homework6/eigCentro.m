function [Q,D] = eigCentro(A)
% A is an nxn centrosymmetric matrix and n is even.
% Q is orthogonal, D is diagonal, and Q’*A*Q = D

n = size(A,2);
m = n/2;

% I = eye(m);
% E = fliplr(I);
% Q1 = 1/sqrt(2)*[I I; E -E];

A11 = A(1:m, 1:m);
A21 = A(m+1:n, 1:m);

% If A is [A11 A12; A21 A22], 
% B = Q1'*A*Q1;
% then B has 2 diagonal blocks equal to A11 + E*A21 and A11 - E*A21
B1 = A11 + flipud(A21);
B2 = A11 - flipud(A21);

% Use matlab's eig function to compute the eigenvalues and eigenvectors of
% 2 size m square matrices (as opposed to 1 size n)
[V1, D1] = eig(B1);
[V2, D2] = eig(B2);
Z = zeros(m,m);
D = [D1 Z; Z D2];

% V'*Q1'*A*Q1*V = D
% so Q = Q1*V = [V1 V2; E*V1 - E*V1]/sqrt(2)
Q = [V1 V2; flipud(V1) -flipud(V2)]/sqrt(2);


