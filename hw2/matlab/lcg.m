classdef lcg < handle
    properties (SetAccess = private)
        a
        b
        m
        seed
    end
    
    properties (Access = protected)
        state
    end
    
    methods
        function obj = lcg(a, b, m, seed)
            if nargin < 4
                seed = 1;
            end
            obj.a = a;
            obj.b = b;
            obj.m = m;
            obj.seed = seed;
            obj.state = seed;
        end
        
        function v = next_one(obj)
            obj.state = mod(obj.state * obj.a + obj.b, obj.m);
            v = obj.state / obj.m;
        end
        
        function vs = next(obj, N)
            vs = zeros(N,1);
            for i=1:N
                vs(i) = next_one(obj);
            end
        end
        
        function reset(obj, seed)
            obj.seed = seed;
            obj.state = seed;
        end
    end
end