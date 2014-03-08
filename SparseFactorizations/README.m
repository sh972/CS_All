% README
%
% This is about using the University of Florida sparse matrix collection
% to learn about Matlab's sparse Cholesky and sparse LU implemnetations.
%
% The URL...
%         http://www.cise.ufl.edu/research/sparse/matrices/
%
% Or simply Google "UF sparse"
%
% The goal is to download a matrix from the collection and to get it
% into yoour Matlab workspace. Follow these steps...
%
% Scroll down to "Search the Collection" and click. Now you
% define the scope of the search...
%
%    Ignore the keyword box.
%    Enter a range for the number of rows.
%    Enter a range for the number of columns.
%    Enter a range for the number of nonzeros.
%    Ignore pattern symmetry.
%    For a general matrix select "unsymmetric" for structure, "no"
%           for positive definite, and "real" for type.
%    For a symmetric positive definite matrix enter "symmetric" for structure,
%          "yes" for positive definite, and "real" for type.
%    Click on "select".
%    Up will come th epossibilities. 
%    Download the matrix and you want the Matlab Format.
%    Copy the downloaded .mat file into the current working directory.
%
%    The actual matrix is part of the .mat file. The given function GetMatrix
%    (assumed to be loacated in your current working directory) 
%    can be use two extract it from the file and turn it into a sparse
%    format matrix.