function ci = mean_ci(x)
gamma = 0.95;
n = length(x);

m = mean(x);
s = sqrt(var(x));

eta = norminv(1 - (1 - gamma)/2);
ci = m + [-eta*s/sqrt(n), +eta*s/sqrt(n)];
end
