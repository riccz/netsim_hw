close all; clear all; clc;

N = 1e5;
lambdas = linspace(0.01, 1e3, 12);
times = zeros(length(lambdas), 3);

for i=1:length(lambdas)
    try
        tic;
        x_cdfinv = poisson_cdfinv(lambdas(i), N);
        times(i, 1) = toc;
        fprintf('.');
    catch ex
        if (strcmp(ex.identifier,'CDFInv:WouldNotTerminate'))
            warning(ex.message);
            times(i, 1) = NaN;
            fprintf('!');
        else
            rethrow(ex);
        end
    end
    
    tic;
    x_exp = poisson_exp(lambdas(i), N);
    times(i, 2) = toc;
    fprintf('.');
    
    try
        tic;
        x_unif = poisson_unif(lambdas(i), N);
        times(i, 3) = toc;
        fprintf('.');
    catch ex
        if (strcmp(ex.identifier,'UnifProd:WouldNotTerminate'))
            warning(ex.message);
            times(i, 3) = NaN;
            fprintf('!');
        else
            rethrow(ex);
        end
    end
    
    fprintf(':');
end
fprintf('\n');

figure;
hold on;
plot(lambdas, times(:,1));
plot(lambdas, times(:, 2));
plot(lambdas, times(:, 3));
xlabel('lambda');
ylabel('execution time');
legend('CDF inversion', 'Exponential interarr.', 'Uniform prod.');
print('poisson_gen', '-depsc');