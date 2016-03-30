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

[pi_old_low, pi_old_upp] = prediction_interval(sgbdold, 0.95);
[pi_new_low, pi_new_upp] = prediction_interval(sgbdnew, 0.95);

sorted_old = sort(sgbdold);
sorted_new = sort(sgbdnew);
first_quartile_old = sorted_old(25);
third_quartile_old = sorted_old(75);
first_quartile_new = sorted_new(25);
third_quartile_new = sorted_new(75);

%iq_dist_old = third_quartile_old - first_quartile_old;
%dispersion_old = 1.5*iq_dist_old;

fprintf('For the old data:\n');
fprintf('  mean: %f CI [%f, %f]\n', mean_old, mean_old_ci_low, mean_old_ci_upp);
fprintf('  median: %f CI [%f, %f]\n', med_old, med_old_ci_low, med_old_ci_upp);
fprintf('  first quartile: %f, third quartile: %f\n', first_quartile_old, third_quartile_old);
fprintf('  prediction interval: [%f, %f]\n', pi_old_low, pi_old_upp);

fprintf('For the new data:\n');
fprintf('  mean: %f CI [%f, %f]\n', mean_new, mean_new_ci_low, mean_new_ci_upp);
fprintf('  median: %f CI [%f, %f]\n', med_new, med_new_ci_low, med_new_ci_upp);
fprintf('  first quartile: %f, third quartile: %f\n', first_quartile_new, third_quartile_new);
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

% Figure 2.10

