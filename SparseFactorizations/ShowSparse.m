  function ShowSparse()
% Displays some sparse matrices from the UF Collection 
close all

% Symmetric Positive Definite Examples...
for i = [1 2 3 4 35 36 45 67 219]
    % Get the matrix, which will be in sparse format.
    A = GetMatrix(['UF' num2str(i) '.mat']);
    [n,n] = size(A);
    spy(A)
    xlabel(sprintf('n = %1d     nnz = %1d     nnz/n = %5.3f',n, nnz(A),nnz(A)/n),'fontsize',16)
    title(sprintf('Symmetric Positive Definite      UF id = %1d',i),'fontsize',16)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(gcf,'position',[200 200 600 600])
    shg
    pause
end

% Unsymmetric matrix Examples...
for i = [104 156 243 246 247 258 1408 2332]
    % Get the matrix, which will be in sparse format.
    A = GetMatrix(['UF' num2str(i) '.mat']);
    [n,n] = size(A);
    spy(A)
    xlabel(sprintf('n = %1d     nnz = %1d     nnz/n = %5.3f',n, nnz(A),nnz(A)/n),'fontsize',16)
    title(sprintf('Unsymmetric      UFid = %1d',i),'fontsize',16)
    set(gca,'yticklabel',[],'xticklabel',[])
    set(gcf,'position',[200 200 600 600])
    shg
    pause
end