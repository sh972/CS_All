  function alfa = Fit(E,x,y)
% E is an ellipse and x and y are column N vectors.
% alfa is the is the "string length" fit of E to the data
%       (x(1),y(i)),...,(x(N),y(N))
% For i=1:N, sVec(i) is the sum of the distance from (x(i),y(i)) to E.F1 
% and the distance of (x(i),y(i)) to E.F2...
sVec = sqrt((x-E.F1x).^2+(y-E.F1y).^2) + sqrt((x-E.F2x).^2+(y-E.F2y).^2);
% The average of these quantities...
sAve = mean(sVec);
% alfa is the sqrt of the sum from i=1:N of (sVec(i)-sAve)^2/N
N = length(x);
alfa = sqrt(sum((sVec-sAve).^2)/N);