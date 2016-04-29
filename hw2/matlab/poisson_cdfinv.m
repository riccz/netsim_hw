function x = poisson_cdfinv(lambda, N)
x = zeros(N, 1);
for i=1:N
    x(i) = one_poisson_cdfinv(lambda);
end
end

function x = one_poisson_cdfinv(lambda)
u = rand(1);
i = 0;
pr = exp(-lambda);
if pr == 0
    throw(MException('CDFInv:WouldNotTerminate', 'exp(-lambda) is zero'));
end
F = pr;
while u >= F
    pr = lambda/(i+1) * pr;
    F = F + pr;
    i = i+1;
end
x = i;
end
