  function ShowSparseChol()
% Illustrates Matlab's sparse Cholesky capabilities using examples
% from the UF sparse matrix collection.

SPD_Indices = [1 2 3 4 35 36 45 67 219];
% Assumes that the .mat files associated with these examples are
% in the current working directory.
for i = SPD_Indices
    % Get the matrix, which will be in sparse format.
    A = GetMatrix(['UF' num2str(i) '.mat']);
    [n,n] = size(A);
    
    % Cholesky....
    G = chol(A,'lower');
    % A = G*G' where G is lower triangular and in sparse format.
    
    % Cholesky with approximate minimum degree pre-ordering...
    [G1,flag,P1] = chol(A,'lower');
    % P1'*A*P1 = G1*G1'  where G1 is lower triangular and P1 is a
    % permutation. G1 and P1 are in sparse format. (flag can signals
    % indefiniteness--ignore.)
    
    % Cholesky with reverse Cuthill--McKee preordering...
    % Get the ordering...
    q = symrcm(A);
    % Represent in sparse format...
    I = speye(n); P2 = I(:,q);
    % Compute P2'*A*P2 = G2*G2'
    G2 = chol(P2'*A*P2,'lower');
    
    
    % Now display the associated sparsity patterns..
    subplot(2,3,1), spy(A), title(sprintf('A       UFid = %1d',i),'FontSize',14)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(get(gca,'xlabel'),'fontsize',16)
    subplot(2,3,4), spy(G), title('Cholesky Factor','FontSize',14)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(get(gca,'xlabel'),'fontsize',16)
    subplot(2,3,2), spy(P1*A*P1'), title('P''AP via amd','FontSize',14)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(get(gca,'xlabel'),'fontsize',16)
    subplot(2,3,5), spy(G1), title('Cholesky Factor','FontSize',14)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(get(gca,'xlabel'),'fontsize',16)
    subplot(2,3,3), spy(A(q,q)), title('P''AP via symrcm','FontSize',14)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(get(gca,'xlabel'),'fontsize',16)
    subplot(2,3,6), spy(G2), title('Cholesky Factor','FontSize',14)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(get(gca,'xlabel'),'fontsize',16)
    shg
    pause(1)
end




    