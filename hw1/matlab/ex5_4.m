close all; clear all; clc;

N = 500;

means = zeros(N, 1);
vars = zeros(N, 1);
var_cis = zeros(N, 2);
pis = zeros(N, 2);
for n=1:N
    g = randn(n, 1);
    
    means(n) = mean(g);
    vars(n) = var(g);
    var_cis(n,:) = variance_ci_gaussian(g);
    pis(n,:) = prediction_interval_gaussian(g);
end

true_m = 0;
true_v = 1;

figure;
hold on;
plot(1:N, means, 'b');
plot(1:N, true_m * ones(N, 1), 'r');
%plot(1:N, true_m + (1:N).^-1, 'b:');
title('sample mean');
xlabel('n');
%ylim([-0.5, 0.5]);
print('normal_mean_n', '-depsc');

figure;
title('sample variance');
hold on;
plot(1:N, var_cis(:,1), 'Color', 'blue', 'LineStyle', ':');
plot(1:N, var_cis(:, 2), 'Color', 'blue', 'LineStyle', ':');
plot(1:N, vars, 'Color', 'blue');
plot(1:N, true_v * ones(N,1), 'Color', 'red');
xlabel('n');
%ylim([0.5, 1.5]);
print('normal_variance_n', '-depsc');

figure;
title('prediction intervals');
hold on;
plot(1:N, -1.96*ones(N,1), 'Color' , 'red');
plot(1:N, 1.96*ones(N,1), 'Color' , 'red');
plot(1:N, pis(:,1), 'Color', 'blue');
plot(1:N, pis(:,2), 'Color', 'blue');
xlabel('n');
print('normal_prediction_interval_n', '-depsc');
