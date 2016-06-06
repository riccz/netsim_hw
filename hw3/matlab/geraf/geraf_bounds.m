function [lower, upper] = geraf_bounds(D, M, iter)
lower = (D-1)/mean_adv(D, M, iter) + 1;
upper = D/mean_adv(1, M, iter) + 1;
end

function [E, varE] = mean_adv(D, M, iter)
a = rand(iter, 1);
A = inters_area(D-a, D);
f = exp(-M.*A./pi);
E = 1 - mean(f);
varE = var(f);
end

function A = inters_area(r, D)
w = (D^2 - r.^2 + 1) ./ (2*D);
A = beta(w, 1) + beta(D-w, r);
end

function b = beta(x, y)
x_y = x./y;
b = 0.5 * (pi - 2*asin(x_y) - 2 * x_y .* sqrt(1 - x_y.^2));
end