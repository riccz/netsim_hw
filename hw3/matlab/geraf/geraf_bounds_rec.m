function [lower, upper] = geraf_bounds_rec(D, M, ni)
lower = lower_bound(D, M, ni);
upper = upper_bound(D, M, ni);
end

function lower = lower_bound(D, M, ni)
n2 = zeros(D*ni, 1);
n2(1:ni) = 1;
for i=ni+1:D*ni
    w = zeros(1, ni);
    for k = 1:ni;
        w(k) = adv_probability(i, k, ni, D, M);
    end
    
    n2_rec = n2(i - ni + (1:ni) -1);
    s = w * n2_rec;
    w0 = zero_adv_probability(i, ni, D, M);
    n2(i) = (1 + s) / (1 - w0);
end
lower = n2(D*ni);
end

function upper = upper_bound(D, M, ni)
n1 = zeros(D*ni, 1);
n1(1:ni) = 1;
for i=ni+1:D*ni
    w = zeros(1, ni-1);
    for k = 1:ni-1;
        w(k) = adv_probability(i, k, ni, D, M);
    end
    
    n1_rec = n1(i - ni + (1:ni-1));
    s = w * n1_rec;
    w0 = zero_adv_probability(i, ni, D, M);
    wini = adv_probability(i, ni, ni, D, M);
    n1(i) = (1 + s) / (1 - w0 -wini);
end
upper = n1(D*ni);
end
