function [queue_size, delays] = simulate_queue_2(time_slots, b)
queue_size = zeros(1, time_slots);
delays = [];
queue = [];
for i=1:time_slots
    % Departure?
    if ~isempty(queue) && rand(1) <= b
        arrival = queue(1);
        queue = queue(2:length(queue));
        delays = [delays, i-arrival];
    end
    
    % Arrival?
    u = rand(1);
    if u <= 0.5
        queue = [queue, i];
    end
    
    queue_size(i) = length(queue);
end
end
