close all; clear all; clc;

N = 1e5;
ns = [10, 50, 100, 200, 1000];
ps = [1e-4 0.01, 0.5, 0.9];
times = zeros(length(ns), length(ps), 3);

for i=1:length(ns)
    for j=1:length(ps)
        try
            tic;
            x_cdfinv = binomial_cdfinv(ns(i), ps(j), N);
            times(i, j, 1) = toc;
            fprintf('.');
        catch ex
            if (strcmp(ex.identifier,'CDFInv:WouldNotTerminate'))
                warning(ex.message);
                times(i, j, 1) = NaN;
                fprintf('!');
            else
                rethrow(ex);
            end
        end
        
        tic;
        x_bernsum = binomial_bernsum(ns(i), ps(j), N);
        times(i, j, 2) = toc;
        fprintf('.');
        
        tic;
        x_geozero = binomial_geozero(ns(i), ps(j), N);
        times(i, j, 3) = toc;
        fprintf('.');
        
        fprintf(':');
    end
    
end
fprintf('\n');

fprintf('Binomial generation timing:\n');
for i=1:length(ns)
    for j=1:length(ps)
        fprintf('n = %d & ', ns(i));
        fprintf('p = %.4f & ', ps(j));
        fprintf('\\SI{%.3f}{\\s} & ', times(i, j, 1));
        fprintf('\\SI{%.3f}{\\s} & ', times(i, j, 2));
        fprintf('\\SI{%.3f}{\\s} ', times(i, j, 3));
        fprintf('\\\\\n');
    end
end
