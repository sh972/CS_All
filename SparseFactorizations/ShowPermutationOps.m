  function ShowPermutationOps()
% Illustrates how to operate with permutation matrices in Matlab.

clc
disp('Definition. A permutation is the identity with its rows reordered:')
 
P = [ 0 1 0 0;...
      0 0 0 1;...
      0 0 1 0;...
      1 0 0 0]
disp('It can be encoded by a single integer vector that indicates where the "1" is in each row:')
r = [2 4 3 1]
I = eye(4)
disp(' ')
disp('P = I(r,:) = ')
disp(' ')
disp(I(r,:))
disp('It can be encoded in sparse format:')
disp(' ')
I = speye(4);
P = I(r,:);
disp('I = speye(4) = ')
disp(' ')
disp(I)
disp('P = I(r,:)= ')
disp(' ')
disp(P)
disp(' ')
disp('Operations on vectors. Suppose')
disp(' ')
x = [10;20;30;40]
disp('If x = P*x then x = x(r)...')
disp(x(r))
disp('If x = P''*x then x(r) = x...')
x(r) = x;
disp(x)
disp('Matrix Updates:')
disp(' ')
disp('    A = A(r,r)  is equivalent to A = P*A*P'' ')
disp('    A(r,r) = A  is equivalent to A = P''*A*P')
disp(' ')
disp('To get r from sparse format: r = P*(1:n)''')
r = P*(1:4)'
disp('**************************************************************')
disp(' ')
disp('The column "view"...')
disp(' ')
disp('Definition. A permutation is the identity with its columns reordered:')
 
P = [ 0 1 0 0;...
      0 0 0 1;...
      0 0 1 0;...
      1 0 0 0]
disp('It can be encoded by a single integer vector that indicates where the "1" is in each column:')
c = [4 1 3 2]
I = eye(4)
disp(' ')
disp('P = I(,c) = ')
disp(' ')
disp(I(:,c))
disp('It can be encoded in sparse format:')
disp(' ')
I = speye(4);
P = I(:,c);
disp('I = speye(4) = ')
disp(' ')
disp(I)
disp('P = I(:,c)= ')
disp(' ')
disp(P)
disp(' ')
disp('Operations on vectors. Suppose')
disp(' ')
x = [10;20;30;40]
disp('If x = P*x then x(c) = x...')
y(c) = x;
disp(y')
disp('If x = P''*x then x = x(c)...')
disp(' ')
disp(x(c))
disp('Matrix Updates:')
disp(' ')
disp('    A = A(c,c)  is equivalent to A = P''*A*P ')
disp('    A(c,c) = A  is equivalent to A = P*A*P''')
disp(' ')
disp('To get c from sparse format: c = P''*(1:n)''')
c = P'*(1:4)'

disp('************************************************************')
disp(' ')
% Sparse Cholesky operations involve permutations
A = GetMatrix('UF1.mat');
[n,n] = size(A);

% Cholesky with approximate minimum degere ordering computes P'A*P = GG';
[G,flag,P] = chol(A,'lower');
ErrorAMD = norm(P'*A*P - G*G',1)

% The reverse Cuthill--McKee preordering:
q = symrcm(A);
% In sparse format...
I = speye(n); P = I(:,q);
% P'AP = GG' ...
G = chol(P'*A*P,'lower');
ErrRCM = norm(P'*A*P - G*G',1)
