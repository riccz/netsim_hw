function [mid, mid_value, lower_bound, upper_bound] = binary_search(f, target, lower_bound, upper_bound)
while true
    mid = round((lower_bound + upper_bound) / 2);
    mid_value = f(mid);
    if upper_bound - lower_bound <= 1 || mid_value == target
        break;
    elseif mid_value > target
        upper_bound = mid;
    else
        lower_bound = mid;
    end
end
end
