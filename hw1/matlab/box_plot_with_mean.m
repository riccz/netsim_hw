function [] = box_plot_with_mean(x)
boxplot(x, 'notch', 'on');

washold = ishold;
hold on;

[m, m_ci_low, m_ci_high] = mean_ci_95(x);
plot(xlim, [m m], 'Color', 'red');
plot(xlim, [m_ci_low m_ci_low], 'Color', 'blue', 'LineStyle', ':');
plot(xlim, [m_ci_high m_ci_high], 'Color', 'blue', 'LineStyle', ':');

if ~washold
    hold off;
end
end

