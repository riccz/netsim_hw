function [m, m_ci_low, m_ci_upp] = mean_ci_95_gaussian(x)
n = length(x);
m = 1/n * sum(x);
s = sqrt(1/(n-1) * sum((x - m).^2));

eta = tinv(0.975, n-1);
m_ci_low = m -eta*s/sqrt(n);
m_ci_upp = m +eta*s/sqrt(n);
end
