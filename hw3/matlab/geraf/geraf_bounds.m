function [lower, upper] = geraf_bounds(D, M, samples)
E1 = mean_adv(1, M, samples);
ED = mean_adv(D, M, samples);

lower = (D-1)/ED + 1;
upper = D/E1 + 1;
end
