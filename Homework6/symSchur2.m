  function [V,D] = symSchur2(A)
% 2x2 symmetric Schur decomposition.
% A is a 2x2 symmetric matrix. Determines a 2x2 orthogonal V so that
% V'AV = D is diagonal.

% Approach. Let V be a rotation: V = [c s; -s c].
% Determine the cosine-sine pair so that if B = V'*AV, then
%  
%    B(1,2) = (A(1,1)-A(2,2))cs + A(1,2)(c^2-s^2) = 0       (1)
% 
% If we can do this then B(2,1) is also zero since B is symmetric.
if A(1,2)==0
   % Nothing to do so
   V = eye(2,2); D = A;
else
    % In this case s cannot be zero so (1) is really a quadratic
    % equation for the cotangent t = c/s ...
    %
    %      A(1,2)*t^2 - (A(2,2)-A(1,1))*t -  A(1,2) = 0
    % Let's compute the smaller root of this quadratic...
    tau = (A(2,2)-A(1,1))/(2*A(1,2));
    if tau>=0
        t = 1/(tau+sqrt(1+tau^2));
    else
        t = 1/(tau-sqrt(1+tau^2));
    end
    % Now deduce the cosine and sine from the cotangent..
    c = 1/sqrt(1+t^2); s = t*c;
    V = [c s; -s c]; 
    D = diag(diag(V'*A*V)); 
end
  
