function x = poisson_unif(lambda, N)
x = zeros(N, 1);
for i=1:N
    x(i) = one_poisson_unif(lambda);
end
end

function x = one_poisson_unif(lambda)
x = 0;
Uprod = rand(1);
c = exp(-lambda);
if c == 0
    throw(MException('UnifProd:WouldNotTerminate', 'exp(-lambda) is zero'));
end
while Uprod >= c
    x = x+1;
    Uprod = Uprod * rand(1);
end
end
