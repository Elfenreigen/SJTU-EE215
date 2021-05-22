hold on;
ylabel('Prob', 'fontsize', 12);
A= [0.0373    0.0734    0.1124    0.1533    0.2022    0.2467    0.2997    0.3584    0.4169   0.4868    0.5517    0.6194    0.6860    0.7476    0.8000    0.8456];
B= [0.0007    0.0020    0.0037    0.0062    0.0092    0.0127    0.0167    0.0225    0.0284   0.0362    0.0471    0.0596    0.0787    0.0999    0.1274    0.1625];

plot(5:20, A, '-', 'markersize', 9, 'Linewidth', 2);

plot(5:20, B, '-', 'markersize', 9, 'Linewidth', 2);
hold off;
grid on; box on;
xlabel('Node Numbers', 'fontsize', 12);
title('Fatal Problems Triggered By Bus Blocking', 'fontsize', 14);


