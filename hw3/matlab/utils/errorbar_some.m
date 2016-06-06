function errorbar_some(x, y, e, bars, varargin)
e_i = unique(round(linspace(1, length(e), bars)));
e_some = NaN .* ones(size(e, 1), size(e, 2));
e_some(e_i) = e(e_i);
errorbar(x,y,e_some,varargin{:});
end
