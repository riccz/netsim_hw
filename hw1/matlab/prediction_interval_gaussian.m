function pi = prediction_interval_gaussian(x)
gamma = 0.95;
n = length(x);

eta = tinv(1 - (1-gamma)/2, n-1);
pi = mean(x) + [-eta*sqrt(1 + 1/n), eta*sqrt(1 + 1/n)] .* sqrt(var(x));
end
