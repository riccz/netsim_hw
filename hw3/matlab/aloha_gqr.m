close all; clear all; clc;
addpath(genpath('./utils/'));
addpath(genpath('./aloha/'));

bs = [6, 10];
ns = 1:30;

% Capture probs.
cn = zeros(length(ns), length(bs));
for j=1:length(bs)
    parfor i=1:length(ns)
        cn(i,j) = aloha_capture_gqr(bs(j), ns(i));
    end
end

% Throughput
G = linspace(0, 30, 200);
S = zeros(length(G), length(bs));
for j=1:length(bs)
    for i=1:length(G)
        poiss = exp(-G(i)) * power(G(i), ns) ./ factorial(ns);
        S(i, j) = sum(transpose(poiss) .* cn(:,j));
    end
end

save('aloha_gqr_data.mat');

% Plot the capture probs.
figure;
hold on;
leg_cap = cell(length(bs), 1);
for j=1:length(bs)
    plot(ns, cn(:,j));
    leg_cap{j} = sprintf('b = %d dB', bs(j));
end
grid on;
legend(leg_cap{:})
xlabel('n');
ylabel('C_n');
xlim([1, 30]);
print('aloha_capture_gqr', '-depsc');

% Plot the throughput
figure;
hold on;
leg_thr = cell(length(bs), 1);
for j=1:length(bs)
    plot(G, S(:,j));
    leg_thr{j} = sprintf('b = %d dB', bs(j));
end
grid on;
legend(leg_thr{:})
xlabel('G');
ylabel('S');
xlim([0, 30]);
print('aloha_thr_gqr', '-depsc');
