function w = adv_probability(i, k, ni, D, M)
if length(i) ~= 1
    error('i can not be a vector');
end
if i < 1 || i > D*ni
    error('1 <= i <= D*ni');
end

w = zeros(size(k, 1), size(k, 2));
k_nonzero = find(~or(k < 1, k > ni));
r1ni = i-ni+k(k_nonzero)-1;
r2ni = i-ni+k(k_nonzero);
A1 = inters_area(r1ni/ni, i/ni);
A1(imag(A1) <= 1e-16) = real(A1(imag(A1) <= 1e-16)); % Handle this corner case where A approx 0 and imag(A) != 0
A2 = inters_area(r2ni/ni, i/ni);
A2(A2 < A1) = A1(A2 < A1); % Crop A1 to A2
w(k_nonzero) = exp(-M .* A1 ./ pi) - exp(-M .* A2 ./ pi);

assert(all(w >= 0) && all(w <= 1) && isreal(w));
end
