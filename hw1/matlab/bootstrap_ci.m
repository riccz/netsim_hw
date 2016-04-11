function ci = bootstrap_ci(est, x)
gamma = 0.95;
r_0 = 25;
R = ceil(2*r_0 / (1-gamma)) - 1;
assert(R == 999);

n = length(x);
vals = zeros(R, 1);
for r=1:R
    is = round(rand(n,1) .* (length(x)-1) +1);
    x_r = x(is);
    vals(r) = est(x_r);
end
vals_sort = sort(vals);
ci(1) = vals_sort(r_0);
ci(2) = vals_sort(R+1-r_0);
end
