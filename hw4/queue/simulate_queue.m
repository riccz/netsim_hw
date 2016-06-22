function counters = simulate_queue(b, slots, slot_duration)
counters = simulate_queue_times(@() slot_duration * geometric(0.5), ...
    @() slot_duration * geometric(b), ...
    slot_duration * slots);
end

function counters = simulate_queue_times(interarr_time, service_time, term_time)
% Initialize
clock = 0;

counters.delays = [];
counters.queuesizes = [];
%counters.busy = [];

state.busy = 0;
state.queued_arrival_times = [];
state.last_event_time = 0;

next_arrival = clock + interarr_time();
next_departure = Inf;

% Iterations
while clock <= term_time
    if next_departure < next_arrival
        state.last_event_time = next_departure;
        
        % Update state
        arrival_time = state.queued_arrival_times(1);
        state.queued_arrival_times = state.queued_arrival_times(2:length(state.queued_arrival_times));
        
        if isempty(state.queued_arrival_times)
            state.busy = 0;
        end
        
        % Store delay
        delay = state.last_event_time - arrival_time;
        counters.delays = [counters.delays, delay];
        
        % Schedule next departure
        if state.busy
            next_departure = state.last_event_time + service_time();
        else
            next_departure = Inf;
        end
    else
        state.last_event_time = next_arrival;
        
        % Update state
        state.queued_arrival_times = [state.queued_arrival_times, state.last_event_time];
        
        if ~state.busy
            state.busy = 1;
            next_departure = state.last_event_time + service_time();
        end
        
        % Schedule next departure
        next_arrival = state.last_event_time + interarr_time();
    end
    
    % Count statistics
    counters.queuesizes = [counters.queuesizes, [state.last_event_time; length(state.queued_arrival_times)]];
    %counters.busy = [counters.busy, [state.last_event_time; state.busy]];
    
    % Advance the clock
    clock = state.last_event_time;
end
end

function x = geometric(p)
x = geornd(p) + 1;
end
