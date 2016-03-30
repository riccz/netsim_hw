function [var_ci_low, var_ci_high] = variance_ci_bootstrap(x)
gamma = 0.95;
r_0 = 25;
R = ceil(2*r_0 / (1-gamma)) - 1;
assert(R == 999);
n = length(x);
v = zeros(R, 1);
for r=1:R 
    is = round(rand(n,1) .* (length(x)-1) +1);
    x_r = x(is);
    v(r) = var(x_r);
end
v_sort = sort(v);
var_ci_low = v_sort(r_0);
var_ci_high = v_sort(R+1-r_0);
end
