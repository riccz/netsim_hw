close all; clear all; clc;
addpath(genpath('./geraf/'));
addpath(genpath('./utils/'));

Ms = linspace(2, 30, 30);
Ds = [5, 10, 20];

ni = 30; % Recursive bounds
Nsim = 1e4; % Simulations

bounds_mc = zeros(length(Ms), length(Ds), 2);
bounds_rec = zeros(length(Ms), length(Ds), 2);
sim = zeros(length(Ms), length(Ds));
sim_var = zeros(length(Ms), length(Ds));
for j=1:length(Ds)
    D = Ds(j);
    parfor i=1:length(Ms)
        [l, u] = geraf_bounds(D, Ms(i));
        bounds_mc(i, j, :) = [l,u];
        
        [l, u] = geraf_bounds_rec(D, Ms(i), ni);
        bounds_rec(i, j, :) = [l,u];
        
        sim_run = zeros(Nsim, 1);
        for k=1:Nsim
            sim_run(k) = geraf_sim(D, Ms(i));
        end
        sim(i, j) = mean(sim_run);
        sim_var(i,j) = var(sim_run);
    end
end

% Figs 1,2,3
for j=1:length(Ds)
    figure;
    
    plot(Ms, bounds_mc(:, j, 1));
    hold on;
    plot(Ms, bounds_mc(:, j, 2));
    
    errorbar_some(Ms, sim(:,j), sqrt(sim_var(:,j)), 10, 1);
    
    legend('Lower MC bound', 'Upper MC bound', 'Simulation');
    
    ylim([0, 50]);
    xlim([0, 30]);
    grid on;

    print(sprintf('sim_mc_%d', Ds(j)), '-depsc');
end

% Figs 8,9,10
for j=1:length(Ds)
    figure;
    
    plot(Ms, bounds_rec(:, j, 1));
    hold on;
    plot(Ms, bounds_rec(:, j, 2));
    
    errorbar_some(Ms, sim(:,j), sqrt(sim_var(:,j)), 10, 1);
    
    legend('Lower recursive bound', 'Upper recursive bound', 'Simulation');
    
    ylim([0, 50]);
    xlim([0, 30]);
    grid on;

     print(sprintf('sim_rec_%d', Ds(j)), '-depsc');
end
