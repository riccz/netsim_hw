
% avg. delay vs rho
close all; clear all; clc;

bs = linspace(0.5, 1, 100);
slots = 1e5;

rhos = 1/2 ./ bs;
avg_d = zeros(1, length(bs));
std_d = zeros(1, length(bs));
for i=1:length(bs)
    [~, delays] = simulate_queue_2(slots, bs(i), Inf, 500);
    avg_d(i) = mean(delays);
    std_d(i) = std(delays);
end

figure;
errorbar_some(rhos, avg_d, std_d, 30);
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
plot(1:slots, queue_size(1,:));
hold on;
plot(1:slots, queue_size(2,:));
plot(1:slots, queue_size(3,:));
legend(['b = ' num2str(as(1))], ['b = ' num2str(as(2))], ['b = ' num2str(as(3))]);
ylim([0 100]);
print('queue_2_sizes_small', '-depsc');
ylim([0, Inf]);
print('queue_2_sizes_big', '-depsc');
