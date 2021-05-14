close all;
x = [1:1:28];
y = 0.3*x.^2+2*x+ceil(abs(100*randn(size(x))));
z = cumsum(y);

hold on

plot(x,z,'r.--');
bar(y,'b');

legend('accumulation','increment','location','northwest');

title('ex for plot and bar');

xlabel('day');
ylabel('total amount');

xlim([0,30]);
ylim([0,7000]);

box on;
grid on;

hold off
