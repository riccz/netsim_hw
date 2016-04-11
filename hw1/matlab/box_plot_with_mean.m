function [] = box_plot_with_mean(x)
boxplot(x, 'notch', 'on');

washold = ishold;
hold on;

m = mean(x);
ci = mean_ci(x);
plot(xlim, m * ones(2,1), 'Color', 'red');
plot(xlim, ci(1) * ones(2,1), 'Color', 'blue', 'LineStyle', ':');
plot(xlim, ci(2) * ones(2,1), 'Color', 'blue', 'LineStyle', ':');

if ~washold
    hold off;
end
end

