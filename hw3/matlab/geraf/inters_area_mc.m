function A = inters_area_mc(r, D, samples)
assert(length(r) == 1);
assert(length(D) == 1);

assert(D >= 1);
assert(r >= D-1 && r <= D);

u = rand(samples, 1);
a = u .* (r-D+1) + D-1;

assert(all(and(a >= D-1, a <= r)));

w = (a.^2 + D^2 - 1) ./ (2 * a * D);
f = 2 * a .* acos(w);
A = (r-D+1) * mean(f);
end
