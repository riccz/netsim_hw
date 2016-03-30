function [low, upp] = prediction_interval_bootstrap(x, gamma)
sorted_x = sort(x);
n = length(x);
alpha = 1- gamma;
if alpha < 2/(n+1)
    warning('cannot compute a prediction interval at this level of confidence');
    low = -inf;
    upp = +inf;
    return;
end
low = sorted_x(floor((n+1)*alpha/2));
upp = sorted_x(ceil((n+1)*(1-alpha/2)));
end

