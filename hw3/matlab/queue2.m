
% avg. delay vs rho
close all; clear all; clc;

bs = linspace(0.5, 1, 100);
slots = 1e5;

rhos = 1/2 ./ bs;
avg_d = zeros(1, length(bs));
ci_d = zeros(2, length(bs));
for i=1:length(bs)
    [~, delays] = simulate_queue_2(slots, bs(i), Inf, 500);
    avg_d(i) = mean(delays);
    ci_d(:,i) = [-1.96; 1.96] .* std(delays) + avg_d(i);
end

figure;
plot(rhos, avg_d);
xlabel('\rho');
ylabel('avg. delay [slots]');
print('queue_2_delay', '-depsc');

% Queue size realization
bs = [1/3, 1/2, 2/3];
slots = 1e4;

for i=1:length(bs)
    queue_size(i,:) = simulate_queue_2(slots, bs(i));
end

figure;
stairs(1:slots, queue_size(1,:), 'g');
hold on;
stairs(1:slots, queue_size(2,:), 'b');
stairs(1:slots, queue_size(3,:), 'r');
ylim([0 100]);
print('queue_2_sizes_small', '-depsc');
ylim([0, Inf]);
print('queue_2_sizes_big', '-depsc');
