close all; clear all; clc;
addpath(genpath('./utils/'));
addpath(genpath('./outage/'));

% Fixed params
b = [6, 10];
N = [1, 3, 4, 7];

nsim = 1e5;
alpha = linspace(0, 1, 100);

outage_prob = zeros(length(alpha), length(N), length(b));
outage_prob_stddev = zeros(length(alpha), length(N), length(b));
for j=1:length(b)
    for i=1:length(N)
        for k=1:length(alpha)
            [outage_prob(k, i, j), outage_prob_stddev(k, i, j)] = outage_sim(b(j), N(i), alpha(k), nsim);
        end
    end
end

save('outage_sim_data.mat');

for j=1:length(b)
    figure;
    hold on;
    leg = cell(length(N), 1);
    for i=1:length(N)
        plot(alpha, outage_prob(:, i, j));
        leg{i} = sprintf('N = %d', N(i));
    end
    legend(leg{:});
    xlim([0, 1]);
    xlabel('alpha');
    ylabel('outage prob.');
    grid on;
    
    print(sprintf('outage_sim_b%d', b(j)), '-depsc');
end
