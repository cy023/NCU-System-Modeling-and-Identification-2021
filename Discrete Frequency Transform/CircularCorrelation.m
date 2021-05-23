function R_xy = CircularCorrelation(x, y)
    N    = double(int32(size(x,2)/2));
    R_xy = zeros([1, N]);
    for i = 1 : N
        temp = 0;
        for j = 1 : N
            temp = temp + x(1,j+i) * y(1,j);
        end
        R_xy(1, i) = temp;
    end
    R_xy = R_xy / double(N);
end