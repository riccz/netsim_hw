function E = mean_adv(D, M)
assert(M >= 0);

f = @(a) integrand(a, D, M);
E = 1 - lg_quad(f, 0, 1, 64);
end

function y = integrand(a, D, M)
A = zeros(size(a, 1), size(a, 2));
for i=1:length(a)
    A(i) = inters_area(D-a(i), D);
end
y = exp(-M * A / pi);
end
