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
m_old = mean(sgbdold);
m_old_ci = mean_ci(sgbdold);
m_new = mean(sgbdnew);
m_new_ci = mean_ci(sgbdnew);

med_old = median(sgbdold);
med_old_ci = median_ci(sgbdold);
med_new = median(sgbdnew);
med_new_ci = median_ci(sgbdnew);

pi_old = prediction_interval(sgbdold);
pi_new = prediction_interval(sgbdnew);

quartiles_old = quantile(sgbdold, 3);
quartiles_new = quantile(sgbdnew, 3);

iq_dist_old = quartiles_old(3) - quartiles_old(1);
dispersion_old = [quartiles_old(1) - 1.5*iq_dist_old, quartiles_old(3) + 1.5*iq_dist_old];

iq_dist_new = quartiles_new(3) - quartiles_new(1);
dispersion_new = [quartiles_new(1) - 1.5*iq_dist_new, quartiles_new(3) + 1.5*iq_dist_new];

fprintf('Data from the box plot of fig.2.3\n');
fprintf('  & Old & New \\\\\n');
fprintf('  Mean & %.3f & %.3f \\\\\n', m_old, m_new);
fprintf('  Mean CI & [%.3f, %.3f] & [%.3f, %.3f] \\\\\n', m_old_ci, m_new_ci);
fprintf('  Median & %.3f & %.3f \\\\\n', med_old, med_new);
fprintf('  Median CI & [%.3f, %.3f] & [%.3f, %.3f] \\\\\n', med_old_ci, med_new_ci);
fprintf('  First quartile & %.3f & %.3f \\\\\n', quartiles_old(1), quartiles_new(1));
fprintf('  Third quartile & %.3f & %.3f \\\\\n', quartiles_old(3), quartiles_new(3));
fprintf('  Dispersion & [%.3f, %.3f] & [%.3f, %.3f] \\\\\n', dispersion_old, dispersion_new);
fprintf('  Prediction interval & [%.3f, %.3f] & [%.3f, %.3f] \\\\\n', pi_old, pi_new);

% Figure 2.7
diff = sgbdold - sgbdnew;
figure;
subplot(1,3,1);
scatter((1:length(diff)), diff, [], 'blue', 'Marker', '+');
subplot(1,3,2);
histogram(diff, 10, 'FaceColor', 'blue');
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
