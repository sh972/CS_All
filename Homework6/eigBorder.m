function [Q,D] = eigBorder(delta,v,alpha)
% delta and v are column vectors with length n-1.
% delta(1) < delta(2) < ... < delta(n-1), v(1),...,v(n-1) are nonzero, and alpha is real.
% Q is orthogonal and D is diagonal and Q’*[diag(delta) v ; v’ alpha]*Q = D.

n = size(delta,1) + 1;
d = zeros(n,1);
intervals = zeros(n,2);

f = @(lambda) lambda + v'*(diag(delta-lambda)\v) - alpha; 

for i = 1:n-1    
    deltai = delta(i);
    e = eps(deltai);
    intervals(i,2) = deltai - 10*e;
    intervals(i+1,1) = deltai + 10*e;
end

change = 2;
intervals(1,1) = intervals(1,2);
while(f(intervals(1,1)) > 0 )
    intervals(1,1) = intervals(1,1) - change;
    change = change * 2;
end

change = 2;
intervals(n,2) = intervals(n,1);
while(f(intervals(n, 2)) < 0 )
    intervals(n,2) = intervals(n,2) + change;
    change = change * 2;
end

arrayfun(@(lambda) f(lambda), intervals)

for i = 1:n
    d(i) = fzero(@(lambda) f(lambda), intervals(i,:));
end

Q = zeros(n,n);
for i=1:n
    P = diag(delta-d(i));
    x = [P\(-v) ; 1];
    Q(:,i) = x / norm(x);
end
D = diag(d);