function capture_prob = aloha_capture_gqr(b, n)
% Fixed params
eta = 4;
sigma_db = 8;
h = @(r) 2*r;

sigma = 0.1 * log(10) * sigma_db;

f = @(csi0_tilde) sub_integral_1(b, n, sigma, eta, h, csi0_tilde * sqrt(2) * sigma);
capture_prob = hg_quad(f, 32, true) / sqrt(pi);
end

function I = sub_integral_1(b, n, sigma, eta, h, csi0)
I = zeros(size(csi0, 1), size(csi0, 2));
for i=1:length(csi0)
    f = @(r0) h(r0) .* sub_integral_2(b, n, sigma, eta, h, csi0(i), r0).^(n-1);
    I(i) = n * lg_quad(f, 0, 1, 64);
end
end

function I = sub_integral_2(b, n, sigma, eta, h, csi0, r0)
I = zeros(size(r0, 1), size(r0, 2));
for i=1:length(r0)
    f = @(csi_tilde) sub_integral_3(b, n, sigma, eta, h, csi0, r0(i), csi_tilde * sqrt(2)*sigma);
    I(i) = hg_quad(f, 32, true) / sqrt(pi);
end
end

function I = sub_integral_3(b, n, sigma, eta, h, csi0, r0, csi)
I = zeros(size(csi, 1), size(csi, 2));
for i=1:length(csi)
    f = @(r) h(r) ./ (1 + db2pow(b) * exp(csi(i) - csi0) * (r / r0).^(-eta));
    I(i) = lg_quad(f, 0, 1, 64);
end
end
