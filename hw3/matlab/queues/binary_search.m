function [mid, final_check, lower_bound, upper_bound] = binary_search(check, lower_bound, upper_bound)
while true
    mid = round((lower_bound + upper_bound) / 2);
    ord = check(mid);
    if ord == 0 || upper_bound - lower_bound < 2
        final_check = ord;
        break;
    elseif ord > 0
        upper_bound = mid;
    else
        lower_bound = mid;
    end
end
end
