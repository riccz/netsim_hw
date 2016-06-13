close all; clear all; clc;
addpath(genpath('./queues/'));
addpath(genpath('./utils/'));

% avg. delay vs rho
bs = linspace(0.5, 1, 51);
slots = 5e5;

rhos = 1/2 ./ bs;
avg_d = zeros(1, length(bs));
std_d = zeros(1, length(bs));
parfor i=1:length(bs)
    [~, delays] = simulate_queue_2(slots, bs(i), Inf);
    avg_d(i) = mean(delays);
    std_d(i) = std(delays);
end

figure;
errorbar_some(rhos, avg_d, std_d, 26);
xlabel('\rho');
ylabel('avg. delay [slots]');
ylim([0, 100]);
xlim([0.5, 1]);
print('queue_2_delay', '-depsc');

% Queue size realization
bs = [1/3, 1/2, 2/3];
slots = 1e4;

for i=1:length(bs)
    queue_size(i,:) = simulate_queue_2(slots, bs(i));
end

for i=1:length(bs)
    figure;
    plot(1:slots, queue_size(i,:));
    xlabel('time slot');
    ylabel('queue size');
    title(sprintf('b = %.2f', bs(i)));
    print(sprintf('queue2_sizes_%d', i), '-depsc');
end
