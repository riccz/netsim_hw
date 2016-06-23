function A = inters_area(r, D)
if length(D) ~= 1
    error('D can not be a vector');
end

assert(D >= 1);
assert(all(and(r >= D-1, r <= D)));

w = (D^2 - r.^2 + 1) ./ (2*D);
A = beta(w, 1) + beta(D-w, r);
end

function b = beta(x, y)
x_y = x./y;
b = 0.5 * (pi - 2*asin(x_y) - 2 * x_y .* sqrt(1 - x_y.^2));
end
