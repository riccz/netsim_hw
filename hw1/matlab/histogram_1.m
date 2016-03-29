function h = histogram_1(x, bins)        
    h(1) = sum(x <= bins(1));
    for i=2:length(bins)
        h(i) = sum(and(x > bins(i-1), x <= bins(i)));
    end    
end

