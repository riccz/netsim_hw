function errorbar_some(x, y, e, bars, eta, linespec)
if ~exist('eta', 'var')
    eta = 1.96;
end
e_i = unique(round(linspace(1, length(e), bars)));
e_some = NaN .* ones(size(e, 1), size(e, 2));
e_some(e_i) = e(e_i);
e_some_l = -eta .* e_some;
e_some_u = eta .* e_some;
if exist('linespec', 'var')
    errorbar(x, y, e_some_l, e_some_u, linespec);
else
    errorbar(x, y, e_some_l, e_some_u);
end
end
