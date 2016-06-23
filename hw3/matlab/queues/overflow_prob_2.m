function [p, p_ci] = overflow_prob_2(queue_lim, b, slots, compute_ci)
queue_sizes = simulate_queue_2(slots, b, queue_lim);

z = sum(queue_sizes == queue_lim);
n = length(queue_sizes);
p = z/n;

if ~exist('compute_ci', 'var') || ~compute_ci
    p_ci = [];
    return;
end

if z < 6
    warning('too few overflows: z = %d', z);
end
if n-z < 6
    warning('too many overflows: n-z = %d', n-z);
end

eta =  norminv((1+0.95)/2);
p_ci = p + eta/n*sqrt(z*(1-p)) .* [-1, +1];
end
