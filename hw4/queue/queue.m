close all; clear all; clc;

% avg. delay vs rho
bs = linspace(0.5, 1, 51);
slots = 5e5;

rhos = 1/2 ./ bs;
avg_d = zeros(1, length(bs));
std_d = zeros(1, length(bs));
parfor i=1:length(bs)
    counters = simulate_queue(bs(i), slots, 1);
    avg_d(i) = mean(counters.delays);
    std_d(i) = std(counters.delays);
end

save('avg_d', 'std_d', 'rhos', 'bs', 'slots');

figure;
errorbar_some(rhos, avg_d, std_d, 26);
xlabel('\rho');
ylabel('avg. delay [slots]');
ylim([0, 100]);
xlim([0.5, 1]);
print('queue_delay', '-depsc');

% Queue size realization
bs = [1/3, 1/2, 2/3];
slots = 1e4;

queue_sizes = cell(length(bs), 1);
for i=1:length(bs)
    counters = simulate_queue(bs(i), slots, 1);
    queue_sizes{i} = counters.queuesizes;
end

for i=1:length(bs)
    figure;
    qs = queue_sizes{i};
    plot(qs(1,:), qs(2,:));
    xlabel('time [slots]');
    ylabel('queue size');
    %title(sprintf('b = %.2f', bs(i)));
    print(sprintf('queue_sizes_%d', i), '-depsc');
end
