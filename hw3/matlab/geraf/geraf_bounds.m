function [lower, upper] = geraf_bounds(D, M)
E1 = mean_adv(1, M);
ED = mean_adv(D, M);

lower = (D-1)/ED + 1;
upper = D/E1 + 1;
end
