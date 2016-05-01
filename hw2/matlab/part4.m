close all; clear all; clc;

a1 = 18;
a2 = 2;
m = 101;

lcg1 = lcg(a1, 0, m, 1);
lcg2 = lcg(a2, 0, m, 1);

notfullperiod1 = [];
notfullperiod2 = [];
for seed=1:m-1
    lcg1.reset(seed);
    lcg2.reset(seed);
    
    rand1 = lcg1.next(m-1);
    rand2 = lcg2.next(m-1);
    
    [x1,i1] = find(histcounts(rand1, m-1) > 1);
    if ~isempty(x1)
        notfullperiod1 = [notfullperiod1 seed];
    end
    
    [x2, i2] = find(histcounts(rand2, m-1) > 1);
    if ~isempty(x2)
        notfullperiod2 = [notfullperiod2 seed];
    end        
end

if isempty(notfullperiod1)
    fprintf('LCG1 is full period\n');
end

if isempty(notfullperiod2)
    fprintf('LCG2 is full period\n');
end

lcg1.reset(1);
u = lcg1.next(m-1);
lcg1.reset(u(1));
u_next = lcg1.next(m-1);

figure;
scatter(u, u_next, '.');

lcg2.reset(1);
u = lcg2.next(m-1);
lcg2.reset(u(1));
u_next = lcg2.next(m-1);

figure;
scatter(u, u_next, '.');