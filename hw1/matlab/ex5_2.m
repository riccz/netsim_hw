close all; clear all; clc;

K = 1000;
n = 48;
mean_confidence_intervals = zeros(K, 2);
true_m = 0;
m_out_count = 0;
for i=1:K
    u = randn(n, 1);
    m = mean(u);
    m_ci = mean_ci_gaussian(u);  
    s = sqrt(var(u));
    mean_confidence_intervals(i,:) = m_ci;
    if true_m < m_ci(1) || true_m > m_ci(2)
        m_out_count = m_out_count + 1;
    end
end

fprintf('The CI does not contain the true mean in %d / %d cases\n', m_out_count, K);

[sorted_low_ci, sort_i] = sort(mean_confidence_intervals(:,1));
mean_confidence_intervals = [sorted_low_ci, mean_confidence_intervals(sort_i, 2)];

figure;
hold all;
plot(1:K, mean_confidence_intervals(:,1), 'Color', 'blue');
plot(1:K, mean_confidence_intervals(:, 2), 'Color', 'blue');
plot(1:K, true_m*ones(K, 1), 'Color', 'red');
print('gaussian_mean_ci', '-depsc');
