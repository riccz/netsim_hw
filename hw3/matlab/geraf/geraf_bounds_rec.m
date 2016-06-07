function [lower, upper] = geraf_bounds_rec(D, M, ni)
lower = lower_bound(D, M, ni);
upper = upper_bound(D, M, ni);
end

function [lower, hops] = lower_bound(D, M, ni)
n2 = zeros(D*ni, 1);
n2(1:ni) = 1;
for i=ni+1:D*ni
    k = 1:ni;
    w = adv_probability(i,k, ni, D, M);
    w0 = exp(-M .* inters_area(i/ni, i/ni) ./ pi);
    n2_rec = n2(i-ni+k-1);
    s = w * n2_rec;
    n2(i) = (1 + s) / (1 - w0);
end
lower = n2(D*ni);
hops = n2;
end

function [upper, hops] = upper_bound(D, M, ni)
n1 = zeros(D*ni, 1);
n1(1:ni) = 1;
for i=ni+1:D*ni
    k = 1:ni-1;
    w = adv_probability(i,k, ni, D, M);
    w0 = exp(-M .* inters_area(i/ni, i/ni) ./ pi);
    wini = adv_probability(i, ni, ni, D, M);
    n1_rec = n1(i-ni+k);
    s = w * n1_rec;
    n1(i) = (1 + s) / (1 - w0 -wini);
end
upper = n1(D*ni);
hops = n1;
end