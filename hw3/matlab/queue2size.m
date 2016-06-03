close all; clear all; clc;

bs = [1/2, 2/3];
slots = 1e4;
p_over_target = 1e-5;

queue_lim_inf = 0;
queue_lim_sup = 10000;
p_over = 1;
while true
    queue_lim = round((queue_lim_inf + queue_lim_sup) / 2);
    [queue_sizes, delays, overflows] = simulate_queue_2(slots, bs(1), queue_lim);
    p_over = sum(queue_sizes == queue_lim) / slots;
    if queue_lim_inf == queue_lim_sup
        break;
    end
    if p_over > p_over_target
        queue_lim_inf = queue_lim;
    else
        queue_lim_sup = queue_lim;
    end
end
