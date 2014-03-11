function sin = Sin(x,y)
sin = asin((x(1).*y(2) - x(2).*y(1))./(norm(x).*norm(y)));