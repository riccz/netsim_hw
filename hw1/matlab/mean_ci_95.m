function [m, m_ci_low, m_ci_upp] = mean_ci_95(x)
n = length(x);
m = 1/n * sum(x);
s = sqrt(1/(n-1) * sum((x - m).^2));

eta = 1.96;
m_ci_low = m -eta*s/sqrt(n);
m_ci_upp = m +eta*s/sqrt(n);
end
