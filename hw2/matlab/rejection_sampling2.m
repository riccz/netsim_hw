function y = rejection_sampling2(f_y, a1, b1, a2,b2, M, N)
y = zeros(N, 2);
i = 1;
while i < N
    x = [rand(1) * (b1 - a1) + a1, rand(1) * (b2 - a2) + a2];
    u = rand(1) * M;
    if u <= f_y(x)
        y(i,:) = x;
        i = i+1;
    end
end
end
