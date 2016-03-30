close all; clear all; clc;

N = 100;

ms = zeros(N, 1);
vs = zeros(N, 1);
v_cis = zeros(N, 2);
pis = zeros(N, 2);
for n=1:N
    u = rand(n, 1);
    
    m = mean(u);
    v = var(u);
    [ci_var_low, ci_var_high] = variance_ci_bootstrap(u);
    [pi_low, pi_high] = prediction_interval_bootstrap(u, 0.95);
    
    ms(n) = m;
    vs(n) = v;
    v_cis(n,:) = [ci_var_low, ci_var_high];
    pis(n,:) = [pi_low pi_high];
end

true_m = 0.5;
true_v = 1/12;

figure;
hold on;
plot(1:N, ms);
plot(1:N, true_m * ones(N, 1));
title('sample mean');
print('uniform_mean_n', '-depsc');

figure;
title('sample variance');
hold on;
plot(1:N, v_cis(:,1), 'Color', 'blue', 'LineStyle', ':');
plot(1:N, v_cis(:, 2), 'Color', 'blue', 'LineStyle', ':');
plot(1:N, vs, 'Color', 'blue');
plot(1:N, true_v * ones(N,1), 'Color', 'red');
print('uniform_variance_n', '-depsc');

figure;
title('prediction intervals');
hold on;
plot(1:N, 0.025*ones(N,1), 'Color' , 'red');
plot(1:N, 0.975*ones(N,1), 'Color' , 'red');
plot(1:N, pis(:,1), 'Color', 'blue');
plot(1:N, pis(:,2), 'Color', 'blue');
print('uniform_prediction_interval_n', '-depsc');


