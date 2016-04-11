function ci = variance_ci_bootstrap(x)
ci = bootstrap_ci(@var, x);
end
