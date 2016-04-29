function x = binomial_cdfinv(n, p, N)
x = zeros(N, 1);
for i=1:N
    x(i) = one_binomial_cdfinv(n, p);
end
end

function x = one_binomial_cdfinv(n, p)
u = rand(1);
c = p/(1-p);
i = 0;
pr = (1-p)^n;
if pr == 0
    throw(MException('CDFInv:WouldNotTerminate', '(1-p)^n is zero'));
end
F = pr;
while u >= F
    pr = c*(n-i)/(i+1)*pr;
    F = F + pr;
    i = i+1;
end
x = i;
end
