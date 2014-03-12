  function DisplayData(x,y)
% x and y are column N vectors that collectively specify N points
% in the plane: (x(1),y(1)),...,(x(N),y(N)).
% Displays these points in a new plot window and leaves the hold toggle
% on so other graphics objects can be added in later.

% Set up a nice plot window with black background...
d = 1+max(max(x)-min(x),max(y)-min(y))/2;
xc = (min(x)+max(x))/2;
yc = (min(y)+max(y))/2;
hold off
axis([xc-d xc+d yc-d yc+d])
fill([xc-d xc+d xc+d xc-d],[yc-d yc-d yc+d yc+d],'k')
axis equal off
hold on
% Display the data...
plot(x,y,'yo')


