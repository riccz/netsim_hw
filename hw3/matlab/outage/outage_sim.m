function [outage_prob, stddev] = outage_sim(b, N, alpha, nsim)
outage_count = 0;
for i=1:nsim
    outage_count = outage_count + outage_sim_one(b, N, alpha);
end
outage_prob = outage_count / nsim;
stddev = 0;
end

function outage = outage_sim_one(b, N, alpha)
% Fixed params
eta = 4;
sigma_db = 8;
n_cells = 6;
R_hex = 3^(3/4) / sqrt(2*pi);

sigma = 0.1 * log(10) * sigma_db;

% Cell sizes
R_cell = sqrt(3*N);
R1 = R_cell - R_hex;
R2 = R_cell + R_hex;

% Number of active interferers
n = binornd(n_cells, alpha);

% R.vs
r0 = sqrt(rand(1));
r = sqrt(rand(n, 1) * (R2-R1) + R1);
csi = sigma * randn(n+1, 1);
shadow = exp(csi);
fading = raylrnd(ones(n+1, 1) ./ sqrt(2));

% SIR
G = fading.^2 .* shadow .* [r0; r].^(-eta);
SIR = G(1) / sum(G(2:n));
b_lin = db2pow(b);
outage = (SIR <= b_lin);
end

