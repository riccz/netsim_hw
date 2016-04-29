function x = poisson_exp(lambda, N)
x = zeros(N, 1);
for i=1:N
    x(i) = one_poisson_exp(lambda);
end
end

function x = one_poisson_exp(lambda)
x = 0;
t = 0;
while t <= 1
    a = -log(rand(1))/lambda;
    t = t + a;
    if t <= 1
        x = x+1;
    end
end
end
