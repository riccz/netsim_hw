function A = inters_area(r, D)
assert(length(r) == 1);
assert(length(D) == 1);

assert(D >= 1);
assert(r >= D-1 && r <= D);

f = @(a) integrand(a, D);
A = lg_quad(f, D-1, r, 16);

assert(isreal(A));
assert(A >= 0);
end

function y = integrand(a, D)
w = (a.^2 + D^2 - 1) ./ (2 * a * D);
y = 2 * a .* acos(w);
end
