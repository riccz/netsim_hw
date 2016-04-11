function ci = mean_ci_gaussian(x)
gamma = 0.95;
n = length(x);

m = mean(x);
s = sqrt(var(x));

eta = tinv(1 - (1-gamma)/2, n-1);
ci = m + [-eta*s/sqrt(n), +eta*s/sqrt(n)];
end
