function p = overflow_prob_2(queue_lim, b, slots, transient)
queue_sizes = simulate_queue_2(slots, b, queue_lim, transient);
p = sum(queue_sizes == queue_lim) / length(queue_sizes);
end