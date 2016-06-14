close all; clear all; clc;
addpath(genpath('./queues/'));
addpath(genpath('./utils/'));

stable_b = 2/3;
p_over_target = 1e-5;
slots = 30e5;
queue_lim_inf = 0;
queue_lim_sup = 100;
check = @(queue_lim, b) sign(p_over_target - overflow_prob_2(queue_lim, b, slots));

[qs, last_cmp] = binary_search(@(queue_lim) check(queue_lim, stable_b), queue_lim_inf, queue_lim_sup);
if last_cmp < 0
    qs = qs+1;
end
estimated_size = qs;

fprintf('b = %f\n', stable_b);
fprintf('  queue size = %d\n', estimated_size);
fprintf('  prob overflow = %f\n', overflow_prob_2(estimated_size, stable_b, slots));
