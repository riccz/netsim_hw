close all; clear all; clc;

% avg. delay vs rho
as = linspace(0, 1/3, 100);
slots = 1e5;

rhos = 3 .* as;
avg_d = zeros(1, length(as));
for i=1:length(as)
    [~, delays] = simulate_queue_1(slots, as(i), Inf, 500);
    avg_d(i) = mean(delays);
end

figure;
plot(rhos, avg_d);
xlabel('\rho');
ylabel('avg. delay [slots]');
print('queue_1_delay', '-depsc');

% Queue size realization
as = [1/4, 1/3, 1/2];
slots = 1e4;

for i=1:length(as)
    queue_size(i,:) = simulate_queue_1(slots, as(i));
end

figure;
stairs(1:slots, queue_size(1,:), 'g');
hold on;
stairs(1:slots, queue_size(2,:), 'b');
stairs(1:slots, queue_size(3,:), 'r');
ylim([0 100]);
print('queue_1_sizes_small', '-depsc');
ylim([0, Inf]);
print('queue_1_sizes_big', '-depsc');
