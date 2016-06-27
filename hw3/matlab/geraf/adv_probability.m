function w = adv_probability(i, k, ni, D, M)
assert(length(i) == 1);
assert(length(k) == 1);

assert(i <= D*ni);
assert(i > ni);

if k < 1 || k > ni
    warning('k out of range: prob. of adv. = 0');
    w = 0;
    return;
end

r1 = i/ni - 1 + (k - 1)/ni;
r2 = i/ni - 1 + k/ni;

A1 = inters_area(r1, i/ni);
A2 = inters_area(r2, i/ni);

w = exp(-M * A1 / pi) - exp(-M * A2 / pi);

assert(w >= 0 && w <= 1);
end
