close all; clear all; clc;
addpath(genpath('./queues/'));
addpath(genpath('./utils/'));

% avg. delay vs rho
as = linspace(0, 1/3, 51);
slots = 1e5;

rhos = 3 .* as;
avg_d = zeros(1, length(as));
std_d = zeros(1, length(as));
parfor i=1:length(as)
    [~, delays] = simulate_queue_1(slots, as(i), Inf);
    avg_d(i) = mean(delays);
    std_d(i) = std(delays);
end

figure;
errorbar_some(rhos, avg_d, std_d, 26);
xlabel('\rho');
ylabel('avg. delay [slots]');
ylim([0, 50]);
xlim([0, 1]);
print('queue_1_delay', '-depsc');

% Queue size realization
as = [1/4, 1/3, 1/2];
slots = 1e4;

for i=1:length(as)
    queue_size(i,:) = simulate_queue_1(slots, as(i));
end

for i=1:length(as)
    figure;
    plot(1:slots, queue_size(i,:));
    xlabel('time slot');
    ylabel('queue size');
    %title(sprintf('a = %.2f', as(i)));
    print(sprintf('queue1_sizes_%d', i), '-depsc');
end
