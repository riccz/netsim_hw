close all; clear all; clc;

% 6.5
rand1 = lcg(16807, 0, 2^31-1, 1, 1000);

figure;
plot(0:999, sort(rand1));
print('uniform_qq', '-depsc');

figure;
% n = 0:30; %length(rand1)-1;
% r = xcorr(rand1, length(n)-1, 'coeff');
% %r = r ./ r(length(n));
% hold on;
% stem(n, r(length(n):2*length(n)-1));
% plot(n, ones(length(n), 1) .* 1.96/sqrt(length(rand1)), 'r:');
% plot(n, ones(length(n), 1) .* -1.96/sqrt(length(rand1)), 'r:');
autocorr(rand1);
print('rand1_autocorr', '-depsc');

% lagplot
figure;
for i=(1:9)
    lag = i*100;
    subplot(3,3,i);
    lagged_rand1 = rand1(1+lag:length(rand1));
    scatter(rand1(1:length(rand1)-lag), lagged_rand1, 'b.');
    title(['lag = ' num2str(lag)]);
end
print('rand1_lagplot', '-depsc');

% Figure 6.7
rand1 = lcg(16807, 0, 2^31-1, 1, 1000);
rand2 = lcg(16807, 0, 2^31-1, 2, 1000);
rand3 = lcg(16807, 0, 2^31-1, rand1(1000), 1000);

% Close seeds
figure;
scatter(rand1, rand2, 'b.');
print('lcg_close_seeds', '-depsc');

% Far seeds
figure;
scatter(rand1, rand3, 'b.');
print('lcg_far_seeds', '-depsc');

% Figure 6.10a
f_y_1 = @(y) sin(y)^2 / y^2;
f_y_2 = @(y) abs(y(1) - y(2));

samples_1 = rejection_sampling(f_y_1, -10, 10, 1, 2000);
samples_2 = rejection_sampling2(f_y_2, 0, 1, 0, 1, 1, 2000);

figure;
histogram(samples_1);
print('rejection_histo', '-depsc');

figure;
scatter(samples_2(:,1), samples_2(:,2), '.');
xlabel('y_1');
ylabel('y_2');
print('rejection_scatter', '-depsc');
