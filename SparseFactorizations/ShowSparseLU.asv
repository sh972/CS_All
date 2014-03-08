  function ShowUFsparseLU()
% Illustrates Matlab's sparse LU capabilities using examples
% from the UF sparse matrix collection.

LU_Indices = [104 156 243 246 247 258 511 540 1152  1196 1408 2332 2398];
% Assumes that the .mat files associated with these examples are
% in the current working directory.
for i = LU_Indices
    % Get the matrix, which will be in sparse format...
    A = GetMatrix(['UF' num2str(i) '.mat']);
    thresh = [.1 .001];
    % Compute the factorization P*inv(D)*A*Q = LU where L is unit lower
    % triangular, U is upper triangular, P is a permutation, 
    % Q is a permutation, and D is a diagonal scaling matrix 
    [L,U,P,Q,D] = lu(A,thresh);
    % Each output matrix is in sparse format.  
    % Display A, PAQ, L and U...
    subplot(2,2,1), spy(A), title(sprintf('A  UFid = %1d',i),'FontSize',14)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(get(gca,'xlabel'),'fontsize',16)
    subplot(2,2,2), spy(P*A*Q), title(sprintf('P*A*Q'),'FontSize',14)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(get(gca,'xlabel'),'fontsize',16)
    subplot(2,2,3), spy(L), title(sprintf('L'),'FontSize',14)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(get(gca,'xlabel'),'fontsize',16)
    subplot(2,2,4), spy(U),title(sprintf('U'),'FontSize',14)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(get(gca,'xlabel'),'fontsize',16)
    shg
    pause
end