function [low, upp] = prediction_interval(x, gamma)
sorted_x = sort(x);
n = length(x);
alpha = 1- gamma;
if alpha < 2/(n+1)
    error('cannot compute a prediction interval at this level of confidence');
end
low = sorted_x(floor((n+1)*alpha/2));
upp = sorted_x(ceil((n+1)*(1-alpha/2)));
end

