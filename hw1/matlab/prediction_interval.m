function pi = prediction_interval(x)
gamma = 0.95;
sorted_x = sort(x);
n = length(x);
alpha = 1- gamma;
if alpha < 2/(n+1)
    warning('cannot compute a prediction interval at this level of confidence');
    pi = [-inf, +inf];
    return;
end
pi(1) = sorted_x(floor((n+1)*alpha/2));
pi(2) = sorted_x(ceil((n+1)*(1-alpha/2)));
end
