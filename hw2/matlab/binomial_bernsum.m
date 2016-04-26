function x = binomial_bernsum(n, p, N)
x = zeros(N, 1);
for i=1:N
    x(i) = one_binomial_bernsum(n, p);
end
end

function x = one_binomial_bernsum(n, p)
x = 0;
for i=1:n
    u = rand(1);
    if u <= p
        x = x+1;
    end
end
end
