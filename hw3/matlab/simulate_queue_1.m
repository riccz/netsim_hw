function [queue_size, delays] = simulate_queue_1(time_slots, a)
delays = [];
queued = 0;
queue_size = zeros(1, time_slots);
for i=1:time_slots
    % Departures
    if queued > 0
        queued = queued -1;
    end
    
    % Arrivals
    u = rand(1);
    if u <= a
        arr = 1;
        delays = [delays, queued+1];
    elseif u <= 2*a
        arr = 2;
        delays = [delays, queued+1];
        delays = [delays, queued+2];
    else
        arr = 0;
    end
    queued = queued + arr;
    queue_size(i) = queued;
end
end
