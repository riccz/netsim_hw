close all; clear all; clc;
addpath(genpath('./utils/'));
addpath(genpath('./aloha/'));

bs = [6, 10];
ns = 1:30;

cn = zeros(length(ns), length(bs));
figure(1);
hold on;
leg = cell(length(bs), 1);
for j=1:length(bs)
    parfor i=1:length(ns)
        cn(i,j) = aloha_capture_gqr(bs(j), ns(i));
    end
    plot(ns, cn(:,j));
    leg{j} = sprintf('b = %d dB', bs(j));
end
grid on;
legend(leg{:})
xlabel('n');
ylabel('C_n');
xlim([1, 30]);
print('aloha_capture_gqr', '-depsc');

figure(2);
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
print('aloha_thr_gqr', '-depsc');

save('aloha_gqr_workspace.mat');
return
load('aloha_sim_workspace.mat');
figure(1);
for j=1:length(bs)
    
end
