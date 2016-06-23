function [E, varE] = mean_adv(D, M, samples)
if D < 2
    error('Before D=2 the results are wrong');
end

a = rand(samples, 1);
A = inters_area(D-a, D);
f = exp(-M .* A ./ pi);

E = 1 - mean(f);
varE = var(f);
end
