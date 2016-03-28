close all; clear all; clc;

K = 1000;
n = 48;
mean_confidence_intervals = zeros(K, 2);
m_out_count = 0;
for i=1:K
    u = rand(n, 1);
    
    m = 1/n * sum(u);
    s = sqrt(1/(n-1) * sum((u - m).^2));
    
    eta = 1.96;
    ci_mean = m + [-eta*s/sqrt(n) eta*s/sqrt(n)];
    
    mean_confidence_intervals(i,:) = ci_mean;
    if 0.5 < ci_mean(1) || 0.5 > ci_mean(2)
        m_out_count = m_out_count + 1;
    end
end

fprintf('The mean CI does not contain 0.5 in %d/%d cases\n', m_out_count, K);

[sorted_low_ci, sort_i] = sort(mean_confidence_intervals(:,1));

mean_confidence_intervals = [sorted_low_ci, mean_confidence_intervals(sort_i, 2)];

figure;
hold all;
plot(1:K, mean_confidence_intervals(:,1), 'Color', 'blue');
plot(1:K, mean_confidence_intervals(:, 2), 'Color', 'blue');
plot(1:K, 0.5*ones(K, 1), 'Color', 'red');
print('uniform_mean_ci', '-depsc');
