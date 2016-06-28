close all; clear all; clc;
addpath(genpath('./utils/'));
addpath(genpath('./aloha/'));

bs = [6, 10];
ns = 1:30;
nsim = 1e6;

cn = zeros(length(ns), length(bs));
cn_stddev = zeros(length(ns), length(bs));
figure;
hold on;
leg = cell(length(bs), 1);
for j=1:length(bs)
    parfor i=1:length(ns)
        [cn(i,j), cn_stddev(i,j)] = aloha_capture_sim(bs(j), ns(i), nsim);
    end
    errorbar_some(ns, cn(:,j), cn_stddev(:,j)/sqrt(nsim), 15, 1.96);
    leg{j} = sprintf('b = %d dB', bs(j));
end
grid on;
legend(leg{:})
xlabel('n');
ylabel('C_n');
xlim([1, 30]);
print('aloha_capture_sim', '-depsc');

figure;
hold on;
leg = cell(length(bs), 1);
G = linspace(0, 30, 200);
S = zeros(length(G), length(bs));
for j=1:length(bs)
    for i=1:length(G)
        poiss = exp(-G(i)) * power(G(i), ns) ./ factorial(ns);
        S(i, j) = sum(transpose(poiss) .* cn(:,j));
    end
    plot(G, S(:,j));
    leg{j} = sprintf('b = %d dB', bs(j));
end
grid on;
legend(leg{:})
xlabel('G');
ylabel('S');
xlim([0, 30]);
print('aloha_thr_sim', '-depsc');
