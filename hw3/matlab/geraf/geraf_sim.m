function hopcount = geraf_sim(D, M)
src = [0,0];
dst =[D,0];
hopcount = 0;
while true
    if sum((dst - src).^2) <= 1
        hopcount = hopcount + 1;
        break;
    else
        neigh_count = poissrnd(M, 1);
        if neigh_count > 0
            [x, y] = uniform_circle(neigh_count);
            x = x + src(1);
            y = y + src(2);
            d2s = (x - dst(1)).^2 + (y - dst(2)).^2;
            [~, best_i] = min(d2s);
            src(1) = x(best_i);
            src(2) = y(best_i);
        end
        hopcount = hopcount + 1;
    end
end
end
