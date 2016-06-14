close all; clear all; clc;
addpath(genpath('./queues/'));
addpath(genpath('./utils/'));

stable_b = 2/3;
p_over_target = 1e-5;
slots = 30e5;
queue_lim_inf = 0;
queue_lim_sup = 64;

[qs, last_p] = binary_search(@(queue_lim) -overflow_prob_2(queue_lim, stable_b, slots), ...
    -p_over_target, queue_lim_inf, queue_lim_sup);
last_p = -last_p;
if last_p < p_over_target
    qs = qs+1;
end
estimated_size = qs;
[check_p, p_ci] = overflow_prob_2(estimated_size, stable_b, slots, true);

fprintf('b = %f\n', stable_b);
fprintf('  queue size = %d\n', estimated_size);
fprintf('  prob overflow = %f\n', check_pi);
fprintf('  CI = [%f, %f]\n', p_ci(:));
