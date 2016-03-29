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

