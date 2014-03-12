function bool = Sudoku(x)
bool = true;
B = [1:9];

function b = alltrue(y)
for i=1:9
    b = b && y[x];
end
end

for i = 1:9
    bool = bool && alltrue(sort(x(i,:)) == B);
    bool = bool && alltrue(sort(x(:,i)) == B');
end

for i = 1:3
    for j = 1:3
        n = 3i-2;
        m = 3j-2;
        k = x[n:3i,m:3j];
        bool = bool && alltrue(sort(k(:)) == B');
    end
end
end