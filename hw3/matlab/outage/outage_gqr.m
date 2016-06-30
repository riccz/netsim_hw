function outage_prob = outage_gqr(b, N, alpha)
% Fixed params
eta = 4;
sigma_db = 8;
R_hex = 3^(3/4) / sqrt(2*pi);

sigma = 0.1 * log(10) * sigma_db;

% Cell sizes
R_cell = sqrt(3*N);
R1 = R_cell - R_hex;
R2 = R_cell + R_hex;

h_r0 = @(r0) 2*r0/R_hex^2;
h_r = @(r) 2*r/(R2^2 - R1^2);

params.b = b;
params.N = N;
params.alpha = alpha;
params.sigma = sigma;
params.eta = eta;
params.R_hex = R_hex;
params.R1 = R1;
params.R2 = R2;
params.h_r0 = h_r0;
params.h_r = h_r;

f = @(csi0_tilde) sub_integral_1(params, csi0_tilde * sqrt(2) * sigma);
outage_prob = 1 - hg_quad(f, 32, true) / sqrt(pi);
end

function I = sub_integral_1(params, csi0)
I = zeros(size(csi0, 1), size(csi0, 2));
for i=1:length(csi0)
    f = @(r0) params.h_r0(r0) .* (1 - params.alpha + params.alpha * sub_integral_2(params, csi0(i), r0)).^(6);
    I(i) = lg_quad(f, 0, params.R_hex, 64);
end
end

function I = sub_integral_2(params, csi0, r0)
I = zeros(size(r0, 1), size(r0, 2));
for i=1:length(r0)
    f = @(csi_tilde) sub_integral_3(params, csi0, r0(i), csi_tilde * sqrt(2)*params.sigma);
    I(i) = hg_quad(f, 32, true) / sqrt(pi);
end
end

function I = sub_integral_3(params, csi0, r0, csi)
I = zeros(size(csi, 1), size(csi, 2));
for i=1:length(csi)
    f = @(r) params.h_r(r) ./ (1 + db2pow(params.b) * exp(csi(i) - csi0) * (r / r0).^(-params.eta));
    I(i) = lg_quad(f, params.R1, params.R2, 64);
end
end
