function y = rejection_sampling(f_y, a, b, M, N)
y = zeros(N, 1);
i = 1;
while i < N
    x = rand(1) * (b - a) + a;
    u = rand(1) * M;
    if u <= f_y(x)
        y(i) = x;
        i = i+1;
    end
end
end
