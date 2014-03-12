function Feb26()

% Here is a problem where there is a single root in the
% initial bracketing interval and it is at the left endpoint..

xStar = BisectionBad(@sin,0, 1,.0001)

  function [xStar,I] = BisectionBad(f,a,b,delta)
% f is a function handle that references a continuous function f(x) 
% of a single variable.
% [a,b] is a bracketing interval for f, i.e.,  f(a)f(b) < 0.
% delta is a nonnegative scalar.
%
% xStar has the property that it is contained in a bracketing interval
% [alfa,beta] that satisfies
%            |
%             |beta-alpha| <= max(delta,eps*max(|alpha|,|beta|))
%
% where eps is the unit roundoff. 
% If nargout==2, then I is a structure array that houses the
% succession of bracketing intervals, i.e., the k-th bracketing 
% interval is [I(k).a,I(k).b]

fa = f(a); 
fb = f(b);
if fa*fb>0
    disp('[a,b] is not a bracketing interval')
    return
end
if nargout==2
    I = struct('a',a,'b',b);
    k = 1;
end
% Throughout the following iteration, [a,b] is always a bracketing interval.
while abs(a-b) > max(delta,eps*max(abs(a),abs(b)))
   mid = (a+b)/2;
   fmid = f(mid);    
   if fa*fmid<0
      % There is a root in [a,mid].
      b  = mid; 
      fb = fmid;
   else
      % There is a root in [mid,b].
      a  = mid; 
      fa = fmid;
   end  
   if nargout==2
       k = k+1;
       I(k) = struct('a',a,'b',b);
   end
end
xStar = (a+b)/2;

