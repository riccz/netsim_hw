close all; clear all; clc;

N = 500;

means = zeros(N, 1);
vars = zeros(N, 1);
var_cis = zeros(N, 2);
pis = zeros(N, 2);
for n=1:N
    u = rand(n, 1);
    
    means(n) = mean(u);
    vars(n) = var(u);
    var_cis(n,:) = variance_ci_bootstrap(u);
    pis(n,:) = prediction_interval(u);
end

true_m = 0.5;
true_v = 1/12;

figure;
hold on;
plot(1:N, means, 'b');
plot(1:N, true_m * ones(N, 1), 'r');
%plot(1:N, true_m + (1:N).^-1, 'b:');
title('sample mean');
xlabel('n')
print('uniform_mean_n', '-depsc');

figure;
title('sample variance');
hold on;
plot(1:N, var_cis(:,1), 'Color', 'blue', 'LineStyle', ':');
plot(1:N, var_cis(:, 2), 'Color', 'blue', 'LineStyle', ':');
plot(1:N, vars, 'Color', 'blue');
plot(1:N, true_v * ones(N,1), 'Color', 'red');
xlabel('n');
print('uniform_variance_n', '-depsc');

figure;
title('prediction intervals');
hold on;
plot(1:N, 0.025*ones(N,1), 'Color' , 'red');
plot(1:N, 0.975*ones(N,1), 'Color' , 'red');
plot(1:N, pis(:,1), 'Color', 'blue');
plot(1:N, pis(:,2), 'Color', 'blue');
xlabel('n');
print('uniform_prediction_interval_n', '-depsc');


