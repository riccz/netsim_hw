function I = lg_quad(f, a, b, n)
[x, w] = lg_coeff(n);
z = (b-a)/2 .* x + (b+a)/2;
dz = (b-a)/2;
I = dz * (transpose(w) * f(z));
end

function [x, w] = lg_coeff(n)
persistent cache;
if isempty(cache) || cache.n ~= n
    fname = sprintf('lg_weights_%d.csv', n);
    lg = csvread(fname);
    cache.x = lg(:,1);
    cache.w = lg(:,2);
    cache.n = n;
end
x = cache.x;
w = cache.w;
end
