function [ecdf, t] = empirical_cdf(x)
sorted_x = sort(x);
t = sorted_x;
n = length(x);
ecdf = zeros(n, 1);
for i=1:n
    i_bigger = find(sorted_x > t(i), 1);
    if isempty(i_bigger)
        count_lesseq = length(t);
    else
        count_lesseq = i_bigger - 1;
    end
    ecdf(i) = 1/n * count_lesseq;
end
end
