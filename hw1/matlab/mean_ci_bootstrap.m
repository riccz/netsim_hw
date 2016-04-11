function ci = mean_ci_bootstrap(x)
ci = bootstrap_ci(@mean, x);
end
