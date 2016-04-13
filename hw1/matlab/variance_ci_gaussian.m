function ci = variance_ci_gaussian(x)
gamma = 0.95;
n = length(x);

zeta = chi2inv((1-gamma)/2, n-1);
xi = chi2inv((1+gamma)/2, n-1);

ci = var(x) .* [zeta/(n-1), xi/(n-1)];
end
