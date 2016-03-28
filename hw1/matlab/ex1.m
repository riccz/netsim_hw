close all; clear all; clc;

load 'data/figure 2.1/sgbdnew.dat'
load 'data/figure 2.1/sgbdold.dat'

% Figure 2.1
figure;
subplot(1,2,1);
scatter((1:length(sgbdold)), sgbdold, 'Marker', '+', 'MarkerEdgeColor', 'blue');
ylim([0, 200]);
title('Old');

subplot(1,2,2);
scatter((1:length(sgbdnew)), sgbdnew, 'Marker', 'O', 'MarkerEdgeColor', 'red');
ylim([0, 200]);
title('New');
print('fig2_1', '-depsc');

% Figure 2.2
[ecdf_old, t_old] = empirical_cdf(sgbdold);
[ecdf_new, t_new] = empirical_cdf(sgbdnew);

figure;
hold all;
stairs(t_old, ecdf_old, 'Color', 'blue');
stairs(t_new, ecdf_new, 'Color', 'red');
legend('Old', 'New');
print('fig2_2', '-depsc');
