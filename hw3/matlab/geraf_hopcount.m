close all; clear all; clc;
addpath(genpath('./geraf/'));
addpath(genpath('./utils/'));

Ms = linspace(3, 30, 20);
Ds = [5, 10, 20];
Nsamples = 1e6;
Nsim = 1e1;

bounds_mc = zeros(length(Ms), length(Ds), 2);
sim = zeros(length(Ms), length(Ds));
sim_var = zeros(length(Ms), length(Ds));
j = 2;
parfor i=1:length(Ms)
    [l, u] = geraf_bounds(Ds(j), Ms(i), Nsamples);
    bounds_mc(i, j, :) = [l,u];
        
    sim_run = zeros(Nsim, 1);
    for k=1:Nsim
        sim_run(i) = geraf_sim([0,0], [Ds(j),0], Ms(i));
    end
    sim(i, j) = mean(sim_run);
    sim_var(i,j) = var(sim_run);
end

figure;
plot(Ms, bounds_mc(:, 2, 1));
hold on;
plot(Ms, bounds_mc(:, 2, 2));

plot(Ms, sim(:,2));

ylim([0, 50]);
xlim([0, 30]);
grid on;

