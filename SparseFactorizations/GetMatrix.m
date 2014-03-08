  function A = GetMatrix(fName)
% fName is the name of a .mat file downloaded from the UF Sparse Matrix Site
% A is the sparse matrix that it encodes.
Eg = load(fName);
A = Eg.Problem.A;


