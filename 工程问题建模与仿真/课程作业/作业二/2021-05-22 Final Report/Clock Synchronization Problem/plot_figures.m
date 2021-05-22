hold on; set(gca, 'fontsize', 12);
yyaxis left; ylabel('工作寿命/小时', 'fontsize', 12);
plot(5 : 20, mean_life(5 : 20), '.-', 'markersize', 9, 'Linewidth', 2);

yyaxis right; ylabel('系统可靠性', 'fontsize', 12);
plot(5 : 20, reliability(5 : 20), '.-', 'markersize', 9, 'Linewidth', 2);

hold off; 
legend('工作寿命', '系统可靠性', 'location', 'southeast');
xlabel('节点数/个', 'fontsize', 12);
title('改进后的工作寿命与系统可靠性', 'fontsize', 14);