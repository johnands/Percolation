% p = [0.54 0.55 0.56 0.57 0.58 0.59];
% s_xi = [780 1617 2400 5000  8342 1.1e4];

pc = 0.59275;      % percolation treshold
p = [0.45 0.50 0.54 0.57 0.58];
s_xi = [50.61 181.3 850 7000 2.7e4];

plot(p, s_xi, '--o')
xlabel('p', 'FontSize', 20);
ylabel('$s_\xi$', 'Interpreter', 'latex', 'FontSize', 15);
title('Divergence of characteristic cluster size');

poly = polyfit(log(abs(p-pc)), log(s_xi), 1);
sigma = -1/poly(1)