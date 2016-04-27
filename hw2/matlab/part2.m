close all; clear all; clc;

N = 1e5;
ns = [10, 100, 1000];
ps = [0.01, 0.5, 0.9];
times = zeros(length(ns), length(ps), 3);

for i=1:length(ns)
    for j=1:length(ps)
        tic;
        x_cdfinv = binomial_cdfinv(ns(i), ps(j), N);
        times(i, j, 1) = toc;
        
        tic;
        x_bernsum = binomial_bernsum(ns(i), ps(j), N);
        times(i, j, 2) = toc;
        
        if n <= 100 || p <= 0.01
            tic;
            x_geozero = binomial_geozero(ns(i), ps(j), N);
            times(i, j, 3) = toc;
        end
        
        fprintf('.');
    end
    fprintf('\n');
end

fprintf('Binomial generation timing:\n');
for i=1:length(ns)
    for j=1:length(ps)
        fprintf('n = %d & ', ns(i));
        fprintf('p = %.3f & ', ps(j));
        fprintf('\\SI{%.3f}{\\s} & ', times(i, j, 1));
        fprintf('\\SI{%.3f}{\\s} & ', times(i, j, 2));
        fprintf('\\SI{%.3f}{\\s} ', times(i, j, 3));
        fprintf('\\\\\n');
    end
end