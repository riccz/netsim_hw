close all; clear all; clc;

a1 = 18;
a2 = 2;
m = 101;

notfullperiod1 = [];
notfullperiod2 = [];
for seed=1:m-1
    rand1 = lcg(a1, 0, m, seed, m-1);
    rand2 = lcg(a2, 0, m, seed, m-1);
    
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
else
    fprintf('LCG1 is not full period\n');
end

if isempty(notfullperiod2)
    fprintf('LCG2 is full period\n');
else
    fprintf('LCG2 is not full period\n');
end

u1 = lcg(a1, 0, m, 1, m-1);
figure;
scatter(u1, circshift(u1, 1), '.');
print('lcg1_scatter', '-depsc');

u2 = lcg(a2, 0, m, 1, m-1);
figure;
scatter(u2, circshift(u2, 1), '.');
print('lcg2_scatter', '-depsc');
