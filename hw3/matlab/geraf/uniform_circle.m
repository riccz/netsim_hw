function [x, y] = uniform_circle(nodes, R)
if nargin < 2
    R = 1;
end
x = rand(1, nodes) .* (2*R) -R;
y = rand(1, nodes) .* (2*R) -R;
while true
    d2 = x.^2 + y.^2;
    del_i = find(d2 > R^2);
    if isempty(del_i)
        break;
    else
        x(del_i) = rand(1, length(del_i)) .* (2*R) -R;
        y(del_i) = rand(1, length(del_i)) .* (2*R) -R;
    end
end
end
