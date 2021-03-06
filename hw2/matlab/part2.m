close all; clear all; clc;

N = 5e4;
ns = round(linspace(100, 750, 15));
ps = [0.01, 0.5, 0.9];
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

% fprintf('Binomial generation timing:\n');
% for i=1:length(ns)
%     for j=1:length(ps)
%         fprintf('n = %d & ', ns(i));
%         fprintf('p = %.4f & ', ps(j));
%         fprintf('\\SI{%.3f}{\\s} & ', times(i, j, 1));
%         fprintf('\\SI{%.3f}{\\s} & ', times(i, j, 2));
%         fprintf('\\SI{%.3f}{\\s} ', times(i, j, 3));
%         fprintf('\\\\\n');
%     end
% end

for j=1:length(ps)
    figure;
    title(['p = ' num2str(ps(j))]);    
hold on;
plot(ns, times(:,j,1));
plot(ns, times(:,j, 2));
plot(ns, times(:,j, 3));
xlabel('n');
ylabel('execution time');
legend('CDF inversion', 'Sum of Bernoullians', 'Geometric string of zeros');
print(['binomial_gen_' num2str(j)], '-depsc');
end

