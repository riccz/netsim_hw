function [x, y] = uniform_circle(nodes)
x = rand(1, nodes) .* 2 -1;
y = rand(1, nodes) .* 2 -1;
while true
    d2 = x.^2 + y.^2;
    del_i = find(d2 > 1);
    if isempty(del_i)
        break;
    else
        x(del_i) = rand(1, length(del_i));
        y(del_i) = rand(1, length(del_i)) .* 2 -1 ;
    end
end
end
