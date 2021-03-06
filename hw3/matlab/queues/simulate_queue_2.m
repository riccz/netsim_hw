function [queue_size, delays] = simulate_queue_2(time_slots, b, queue_lim)
if nargin < 3
    queue_lim = Inf;
end
transient = ceil(log(1e-3)/log(1 - b)); % Max service time w.p. 0.999
queue_size = zeros(1, time_slots);
delays = [];
queue = [];
for i=1:time_slots+transient
    % Departure?
    if ~isempty(queue) && rand(1) <= b
        arrival = queue(1);
        queue = queue(2:length(queue));
        if i > transient
            delays = [delays, i-arrival];
        end
    end
    
    % Arrival?
    u = rand(1);
    if u <= 0.5
        if length(queue) < queue_lim
            queue = [queue, i];
        end
    end
    
    queue_size(i) = length(queue);
end
queue_size = queue_size(transient+1:length(queue_size));
end
