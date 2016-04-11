close all; clear all; clc;

load 'data/figure 2.1/sgbdnew.dat'
load 'data/figure 2.1/sgbdold.dat'

% Figure 2.1
figure;
subplot(2,2,1);
scatter((1:length(sgbdold)), sgbdold, 'Marker', '+');
ylim([0, 200]);
title('Old');

subplot(2,2,2);
scatter((1:length(sgbdnew)), sgbdnew, 'Marker', 'O');
ylim([0, 200]);
title('New');

h_bins = linspace(0, 200, 10+1);
h_bins = h_bins(2:11);
h_old = histogram_1(sgbdold, h_bins);
h_new = histogram_1(sgbdnew, h_bins);

subplot(2,2,3);
bar(h_bins, h_old);
xlim([0 220]);
set(gca,'XTick', 20:40:200);

subplot(2,2,4);
bar(h_bins, h_new);
xlim([0 220]);
set(gca,'XTick', 20:40:200);

print('fig2_1', '-depsc');

% Figure 2.2
[ecdf_old, t_old] = empirical_cdf(sgbdold);
[ecdf_new, t_new] = empirical_cdf(sgbdnew);

figure;
hold all;
stairs(t_old, ecdf_old);
stairs(t_new, ecdf_new);
legend('Old', 'New');
print('fig2_2', '-depsc');

% Figure 2.3
[med_old, med_old_ci_low, med_old_ci_upp] = median_ci_95(sgbdold);
[med_new, med_new_ci_low, med_new_ci_upp] = median_ci_95(sgbdnew);

[mean_old, mean_old_ci_low, mean_old_ci_upp] = mean_ci_95(sgbdold);
[mean_new, mean_new_ci_low, mean_new_ci_upp] = mean_ci_95(sgbdnew);

[pi_old_low, pi_old_upp] = prediction_interval_bootstrap(sgbdold, 0.95);
[pi_new_low, pi_new_upp] = prediction_interval_bootstrap(sgbdnew, 0.95);

sorted_old = sort(sgbdold);
sorted_new = sort(sgbdnew);
first_quartile_old = sorted_old(25);
third_quartile_old = sorted_old(75);
first_quartile_new = sorted_new(25);
third_quartile_new = sorted_new(75);

iq_dist_old = third_quartile_old - first_quartile_old;
dispersion_old_low = first_quartile_old - 1.5*iq_dist_old;
dispersion_old_high = third_quartile_old + 1.5*iq_dist_old;

iq_dist_new = third_quartile_new - first_quartile_new;
dispersion_new_low = first_quartile_new - 1.5*iq_dist_new;
dispersion_new_high = third_quartile_new + 1.5*iq_dist_new;


fprintf('For the old data:\n');
fprintf('  mean: %f CI [%f, %f]\n', mean_old, mean_old_ci_low, mean_old_ci_upp);
fprintf('  median: %f CI [%f, %f]\n', med_old, med_old_ci_low, med_old_ci_upp);
fprintf('  first quartile: %f, third quartile: %f\n', first_quartile_old, third_quartile_old);
fprintf('  dispersion: [%f,, %f]\n', dispersion_old_low, dispersion_old_high);
fprintf('  prediction interval: [%f, %f]\n', pi_old_low, pi_old_upp);

fprintf('For the new data:\n');
fprintf('  mean: %f CI [%f, %f]\n', mean_new, mean_new_ci_low, mean_new_ci_upp);
fprintf('  median: %f CI [%f, %f]\n', med_new, med_new_ci_low, med_new_ci_upp);
fprintf('  first quartile: %f, third quartile: %f\n', first_quartile_new, third_quartile_new);
fprintf('  dispersion: [%f,, %f]\n', dispersion_new_low, dispersion_new_high);
fprintf('  prediction interval: [%f, %f]\n', pi_new_low, pi_new_upp);

% Figure 2.7
diff = sgbdold - sgbdnew;
figure;
subplot(1,3,1);
scatter((1:length(diff)), diff, 'Marker', '+');
subplot(1,3,2);
histogram(diff, 10);
subplot(1,3,3);
box_plot_with_mean(diff);
print('diff_plots', '-depsc');

% Figure 2.8
m_old = mean(sgbdold);
m_old_ci = mean_ci(sgbdold);
m_old_ci_gaussian = mean_ci_gaussian(sgbdold);
m_old_ci_bootstrap = mean_ci_bootstrap(sgbdold);

m_new = mean(sgbdnew);
m_new_ci = mean_ci(sgbdnew);
m_new_ci_gaussian = mean_ci_gaussian(sgbdnew);
m_new_ci_bootstrap = mean_ci_bootstrap(sgbdnew);

figure;
hold on;
errorbar([1, 2], [m_old, m_new], [m_old_ci_gaussian(1), m_new_ci_gaussian(1)], [m_old_ci_gaussian(2), m_new_ci_gaussian(2)], 'bx');
errorbar([1.2, 2.2], [m_old, m_new], [m_old_ci(1), m_new_ci(1)], [m_old_ci(2), m_new_ci(2)], 'rx');
errorbar([1.4, 2.4], [m_old, m_new], [m_old_ci_bootstrap(1), m_new_ci_bootstrap(1)], [m_old_ci_bootstrap(2), m_new_ci_bootstrap(2)], 'gx');
set(gca,'XTick', [1,2]);
print('cis_plot', '-depsc');

% Figure 2.10
load 'data/figure 2.10/joe.dat'
k = 0:length(joe)-1;

% 2.10 a)
figure;
plot(k, joe, 'b');
print('joe_data', '-depsc');

% 2.10 c)
r = xcorr(joe, 'coeff');
figure;
hold on;
stem(k, r(length(k):2*length(k)-1), 'b');
plot(k, ones(length(k), 1) .* 1.96/sqrt(length(joe)), 'r:');
plot(k, ones(length(k), 1) .* -1.96/sqrt(length(joe)), 'r:');
print('joe_autocorr', '-depsc');

% 2.10 d)
figure;
for lag=1:9
    subplot(3,3,lag);
       joe_lag = joe(1+lag:length(joe));
    plot(joe(1:length(joe)-lag), joe_lag, 'b.');
     title(['lag = ' num2str(lag)]);
end
print('lagplot', '-depsc');
