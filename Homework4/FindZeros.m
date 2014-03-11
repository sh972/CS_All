function xRoots = FindZeros(alpha)
% alpha is a positive real number.
% xRoots is a column that houses all the roots (in left-to-right order) of the function
%
% f(x) sin(alpha*x) - x
%
% that occur in the interval [-1,1].

f = @(x,alpha) sin(alpha.*x) - x;

% Calculate number of roots, n, and initializes xRoots
if alpha < pi/2
    n = 1;
else
    n = floor((alpha - pi./2)./(2*pi));
    n = (n + 1) * 4 - 1;
end
xRoots = zeros(n,1);

% Find distance between crests
% x is the location of the first crest
% b is the distance from a trough to the next crest
% c is the distance from a crest to the next trough
x = (acos(1./alpha)./alpha);
b = 2*x;
c = (2*pi./alpha) - b;

% i is the center point xRoots
i = (n+1)/2;

% Looks for positive roots, and inverts them for negative roots
% Each periodically updated x is the position of a crest and v is the
%   interval
% Finds the first positive and negative roots first because they wrap the 0
%   root.
if i >= 2
    j = i+1;
    k = i-1;
    v = [x (x+c)];
    xRoots(j) = fzero(@(x) f(x,alpha), v);
    xRoots(k) = -xRoots(j);
    x = x+c;
end

for h = 1:(i-2)/2
    j = j+1;
    k = k-1;
    v = [x (x+b)];
    xRoots(j) = fzero(@(x) f(x,alpha), v);
    xRoots(k) = -xRoots(j);
    x = x+b;
    
    j = j+1;
    k = k-1;
    v = [x (x+c)];
    xRoots(j) = fzero(@(x) f(x,alpha), v);
    xRoots(k) = -xRoots(j);
    x = x+c;
end
