close all; clear all; clc;

a = 65539;
m = 2^31;

figure(1);
hold on;
figure(2);
hold on;
view(-36, 22);

chunksize = 1e5;
iters = ceil((m-1) / chunksize);
last_x = 1;
for i=1:iters
    if i == iters
        chunksize = m-1 - (i-1)*chunksize;
    end
    [u, x] = lcg(a, 0, m, last_x, chunksize+2);
    u1 = u(1:chunksize);
    u2 = u(2:chunksize+1);
    u3 = u(3:chunksize+2);
    
    figure(1);
    scatter(u1, u2, 'b.');
    
    figure(2);
    scatter3(u1, u2, u3, 'b.');
    
    last_x = x(chunksize+1);
    break;
end

figure(1);
print('lcg_big_2d', '-depsc');
figure(2);
print('lcg_big_3d', '-depsc');
