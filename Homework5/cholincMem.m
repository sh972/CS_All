function G = cholincMem(A,p) 
% A is nxn, symmetric, and positive definite and in sparse format.
% G is an incomplete lower triangular cholesky factor in sparse format.
% If delta = ’0’ then spy(G) and spy(tril(A)) look the same.
% Otherwise, delta>0 and G(i,j) that are insignificant relative to an
% intelligent multiple delta are set to zero.
[n,n] = size(A);
v = zeros(n,1);
G = sparse([],[],[],n,n,nnz(tril(A))+p*n);
for j=1:n
    % Compute the j-th column of G...
    v(j:n) = A(j:n,j) - G(j:n,1:j-1)*G(j,1:j-1)';
    % The diagonal entry...
    G(j,j) = v(j)/sqrt(v(j));

    % Compute the maximum number of allowable nonzeros in G(j+1:n,j)...
    q = nnz(A(j+1:n,n)) + p;

    % Set G(i,j) = v(i)/G(j,j) if |v(i)| is one of the q largest entries in |v(j+1:n)|
    % and set it to zero otherwise.
    if (n-j) < q
        G(j+1:n,j) = v(j+1:n)/G(j,j);
    elseif q == 0
    else
        w = sort(abs(v(j+1:n)),'descend');
        lim = w(q);
        for i=j+1:n
            if abs(v(i)) >= lim
                G(i,j) = v(i)/G(j,j);
            end
        end
    end
end

