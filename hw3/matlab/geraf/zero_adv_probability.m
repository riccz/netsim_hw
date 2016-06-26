function w0 = zero_adv_probability(i, ni, D, M)
assert(M >= 0);
assert(i > ni && i <= D*ni);
w0 = exp(-M * inters_area(i/ni, i/ni) / pi);
end