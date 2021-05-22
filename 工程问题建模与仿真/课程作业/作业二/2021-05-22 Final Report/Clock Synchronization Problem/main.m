clc; clear; tic;
% initialize;
initialize_add_B;
for n = 5 : n_max
    FB_count = 0;
%     simulate;
    simulate_add_B;
    mean_life(n) = mean(Life);
    reliability(n) = sum(Life > 2.5e4) / n_samples;
    FB_proportion(n) = FB_count / sum(Life < 9e4);
    fprintf('\nCurrent system has %d nodes\n', n);
    fprintf('The mean life is: %.2f h\n', mean_life(n));
    fprintf('The reliability is: %.2f %%\n', reliability(n) * 100);
end
[best_reli, best_num_1] = max(reliability);
[best_life, best_num_2] = max(mean_life);
fprintf('\nThe best solution to reliability contains %d nodes\n', best_num_1);
fprintf('The best reliability is: %.2f %%\n', best_reli * 100);
fprintf('\nThe best solution to system life contains %d nodes\n', best_num_2);
fprintf('The best system life is: %.2f h\n', best_life);
fprintf('\nThe execution time is: %.2f s\n', toc); 
FB_proportion
plot_figures;