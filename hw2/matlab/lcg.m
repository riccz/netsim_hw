function [u, x] = lcg(a, b, m, seed, N)
assert(m > 0);
assert(a < m);
assert(b < m);
assert(seed < m);

x = zeros(N, 1);
x(1) = seed;
for i=2:N
    x(i) = mod(x(i-1) * a + b, m);
end
u = x ./ m;
end
