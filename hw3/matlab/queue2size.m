close all; clear all; clc;
addpath(genpath('./queues/'));
addpath(genpath('./utils/'));

bs = [1/2, 2/3];
p_over_target = 1e-5;
slots = 30e5;
transient = 500;
queue_lim_inf = 0;
queue_lim_sup = 500;
check = @(queue_lim, b) sign(p_over_target - overflow_prob_2(queue_lim, b, slots, transient));

estimated_sizes = zeros(1, length(bs));
parfor i=1:length(bs)
    [qs, last_cmp] = binary_search(@(queue_lim) check(queue_lim, bs(i)), queue_lim_inf, queue_lim_sup);
    if last_cmp < 0
        qs = qs+1;
    end
    estimated_sizes(i) = qs;
end

for i=1:length(bs)
    fprintf('b = %f\n', bs(i));
    fprintf('  queue size = %d\n', estimated_sizes(i));
    fprintf('  prob overflow = %f\n', overflow_prob_2(estimated_sizes(i), bs(i), slots, transient));
end
