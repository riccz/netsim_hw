close all; clear all; clc;

% avg. delay vs rho
as = linspace(0, 1/3, 100);
slots = 1e5;

rhos = 3 .* as;
avg_d = zeros(1, length(as));
std_d = zeros(1, length(as));
for i=1:length(as)
    [~, delays] = simulate_queue_1(slots, as(i), Inf, 500);
    avg_d(i) = mean(delays);
    std_d(i) = std(delays);
end

figure;
errorbar_some(rhos, avg_d, std_d, 30);
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
plot(1:slots, queue_size(1,:));
hold on;
plot(1:slots, queue_size(2,:));
plot(1:slots, queue_size(3,:));
legend(['a = ' num2str(as(1))], ['a = ' num2str(as(2))], ['a = ' num2str(as(3))]);
ylim([0 100]);
print('queue_1_sizes_small', '-depsc');
ylim([0, Inf]);
print('queue_1_sizes_big', '-depsc');
