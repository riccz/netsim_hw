function I = hg_quad(f, n, exp_times_f)
[x, w] = hg_coeff(n);
if ~exp_times_f
    w = w .* exp(x.^2);
end
I = (transpose(w) * f(x));
end

function [x, w] = hg_coeff(n)
persistent cache;
if isempty(cache) || cache.n ~= n
    fname = sprintf('hg_weights_%d.csv', n);
    lg = csvread(fname);
    cache.x = lg(:,1);
    cache.w = lg(:,2);
    cache.n = n;
end
x = cache.x;
w = cache.w;
end
