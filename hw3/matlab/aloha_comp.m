close all; clear all; clc;
addpath(genpath('./utils/'));
%addpath(genpath('./aloha/'));

% Plot the capture probs.
figure;
hold on;
leg_cap = cell(2*length(bs), 1);
load('aloha_sim_data.mat');
for j=1:length(bs)
    errorbar_some(ns, cn(:,j), cn_stddev(:,j)/sqrt(nsim), 15, 1.96);
    leg_cap{j} = sprintf('b = %d dB - Monte Carlo', bs(j));
end
load('aloha_gqr_data.mat');
for j=1:length(bs)
    plot(ns, cn(:,j));
    leg_cap{length(bs)+j} = sprintf('b = %d dB - GQR', bs(j));
end
grid on;
legend(leg{:})
xlabel('n');
ylabel('C_n');
xlim([1, 30]);
print('aloha_capture_comp', '-depsc');

% Plot the throughput
figure(2);
hold on;
leg_thr = cell(2*length(bs), 1);
load('aloha_sim_data.mat');
for j=1:length(bs)
    plot(G, S(:,j));
    leg_thr{j} = sprintf('b = %d dB - Monte Carlo', bs(j));
end
load('aloha_gqr_data.mat');
for j=1:length(bs)
    plot(G, S(:,j));
    leg_thr{length(bs)+j} = sprintf('b = %d dB - GQR', bs(j));
end
grid on;
legend(leg_thr{:})
xlabel('G');
ylabel('S');
xlim([0, 30]);
print('aloha_thr_comp', '-depsc');
