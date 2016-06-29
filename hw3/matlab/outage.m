close all; clear all; clc;
addpath(genpath('./utils/'));
addpath(genpath('./outage/'));

b = [6, 10];
N = [1, 3, 4, 7];

nsim = 1e4;

outage_prob = zeros(length(N), length(b));
for j=1:length(b)
    for i=1:length(N)
        outage_prob(i, j) = outage_sim(b(j), N(i), nsim);
    end
end
