close all; clear all; clc;

a = 65539;
m = 2^31;

figure(1);
hold on;
    grid on;
    figure(2);
    hold on;
    grid on;
    
chunksize = m/128;
iters = ceil((m-1) / chunksize);
last_x = 1;
for i=1:iters
    [u, x] = lcg(a, 0, m, last_x, chunksize+1);
    u = u(1:chunksize);
    
    if find(histcounts(u, chunksize) > 1)
        error('not full period!!!!!!');
    end
    
    u_shift = lcg(a, 0, m, x(2), chunksize);
    u_shift_shift = lcg(a, 0, m, x(3), chunksize);
    
    figure(1);    
    scatter(u, u_shift, 'b.');
    
    figure(2);    
    scatter3(u, u_shift, u_shift_shift, 'b.');
    
    last_x = x(chunksize+1);
    pause;
end
