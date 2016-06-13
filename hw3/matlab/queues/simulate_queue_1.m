function [queue_size, delays] = simulate_queue_1(time_slots, a, queue_lim)
if nargin < 3
    queue_lim = Inf;
end
transient = 1; %Max service time
delays = [];
queued = 0;
queue_size = zeros(1, time_slots);
for i=1:time_slots+transient
    % Departures
    if queued > 0
        queued = queued -1;
    end
    
    % Arrivals
    u = rand(1);
    if u <= a
        arr = 1;
        if i > transient
            delays = [delays, queued+1];
        end
    elseif u <= 2*a
        arr = 2;
        if i > transient
            delays = [delays, queued+1];
            delays = [delays, queued+2];
        end
    else
        arr = 0;
    end
    queued = min(queued + arr, queue_lim);
    queue_size(i) = queued;
end
queue_size = queue_size(transient+1:length(queue_size));
end
