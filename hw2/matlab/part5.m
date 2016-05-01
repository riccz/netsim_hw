close all; clear all; clc;

a = 65539;
m = 2^31;

the_lcg = lcg(a, 0, m);

u = the_lcg.next(m-1);
the_lcg.reset(u(1));
u_next = the_lcg.next(m-1);
the_lcg.reset(u_next(1));
u_next_next = the_lcg.next(m-1);

figure;
scatter(u, u_next, '.');

figure;
scatter3(u, u_next, u_next_next, '.');