function I = lg_quad(f, a, b, n)
[x, w] = lg_coeff(n);
z = (b-a)/2 .* x + (b+a)/2;
dz = (b-a)/2;
I = dz * (transpose(w) * f(z));
end

function [x, w] = lg_coeff(n)
fname = sprintf('lg_weights_%d.csv', n);
lg = csvread(fname);
x = lg(:,1);
w = lg(:,2);
end
