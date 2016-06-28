function capture_prob = aloha_capture_sim(b, n, nsim)
if n == 1
    capture_prob = 1;
    return;
end
captured = aloha_captured(b, n, nsim);
capture_prob = captured * n / nsim;
end

function captured = aloha_captured(b, n, nsim)
% Fixed params
eta = 4;
sigma_db = 8;

sigma = 0.1 * log(10) * sigma_db;

b_lin = db2pow(b);
captured = 0;
for i=1:nsim
    % Random variables
    r = sqrt(rand(n, 1));
    csi = sigma * randn(n, 1);
    shadow = exp(csi);
    fading = raylrnd(ones(n, 1) ./ sqrt(2));
    
    % SIR
    G = fading.^2 .* shadow .* r.^(-eta);
    SIR = G(1) / sum(G(2:n));
    captured = captured + (SIR > b_lin);
end
end
