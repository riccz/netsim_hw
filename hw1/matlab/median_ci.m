function ci = median_ci(x)
sorted_x = sort(x);
n = length(x);

% if mod(n, 2) == 1
%     med = sorted_x(ceil(n/2));
% else
%     med = 0.5 * (sorted_x(n/2) + sorted_x(n/2 + 1));
% end

p = 0.5;
eta = norminv(1-p/2);
j = floor(n*p - eta*sqrt(n*p*(1-p)));
k = ceil(n*p + eta*sqrt(n*p*(1-p))) + 1;
ci(1) = sorted_x(j);
ci(2) = sorted_x(k);
end
