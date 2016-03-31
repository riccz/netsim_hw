function [m, m_ci_low, m_ci_high] = mean_ci_95_bootstrap(x)
gamma = 0.95;
r_0 = 25;
R = ceil(2*r_0 / (1-gamma)) - 1;
assert(R == 999);
n = length(x);
ms = zeros(R, 1);
for r=1:R 
    is = round(rand(n,1) .* (length(x)-1) +1);
    x_r = x(is);
    ms(r) = mean(x_r);
end
ms_sort = sort(ms);
m_ci_low = ms_sort(r_0);
m_ci_high = ms_sort(R+1-r_0);
m = mean(x);
end
