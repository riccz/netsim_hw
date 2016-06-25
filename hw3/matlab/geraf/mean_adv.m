function [E, varE] = mean_adv(D, M, samples)
a = rand(samples, 1);
A = inters_area(D-a, D);
f = exp(-M .* A ./ pi);

E = 1 - mean(f);
varE = var(f);
end
