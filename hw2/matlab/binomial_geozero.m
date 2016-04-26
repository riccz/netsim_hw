function x = binomial_geozero(n, p, N)
x = zeros(N, 1);
for i=1:N
    x(i) = one_binomial_geozero(n, p);
end
end

function x = one_binomial_geozero(n, p)
x = 0;
i = 0;
while i <= n
    k = geometric(p);
    i = i+k;
    if (i <= n)
        x = x + 1;
        i = i+1;
    end
end
end

function x = geometric(theta)
u = rand(1);
x = floor(log(u)/log(1-theta));
end
