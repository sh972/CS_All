function Jan27()
A = magic(3)
F = [1 2 3; 2 4 5; 3 5 6]
G = [7 8 9; 8 10 11; 9 11 12]
M = [A F ; G -A']
N = M*M
N_Check = Square(A,F,G)
disp('N(1:3,1:3) = N(4:6,4:6)')
disp('N(1:3,4:6)'' = -N(1:3,4:6)')
disp('N(4:6,1:3)'' = -N(4:6,1:3')


  function N = Square(A,F,G)
% N = M*M where M = [A F;G -A'] with F = F' and G = G'
% N = [A F;G -A']*[A F;G - A'] =[N11 N12; N21 N11']
% where
%    N11 = A*A+F*G  
%    N12 = A*F-F*A' = (A*F) -(A*F)'
%    N21 = G*A-A'*G = (G*A) -(G*A)'
N11 = A*A+F*G
N12 = A*F; N12 = N12-N12';
N21 = G*A; N21 = N21-N21';
N = [N11 N12; N21 N11'];

