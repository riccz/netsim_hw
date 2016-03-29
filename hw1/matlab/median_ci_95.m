function [med, ci_low, ci_upp] = median_ci_95(x)
sorted_x = sort(x);
n = length(x);

if mod(n, 2) == 1
    med = sorted_x(ceil(n/2));
else
    med = 0.5 * (sorted_x(n/2) + sorted_x(n/2 + 1));
end

p = 0.5;
eta = 1.96;
j = floor(n*p - eta*sqrt(n*p*(1-p)));
k = ceil(n*p + eta*sqrt(n*p*(1-p))) + 1;
ci_low = sorted_x(j);
ci_upp = sorted_x(k);
end

