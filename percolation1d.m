clc;
clear;

p = [0.9 0.95 0.98];
s = linspace(0, 100000, 1000);
legendInfo = cell(length(p), 1);
for i = 1:length(p)
    nsp = p(i).^s;
    sxi = -1/log(p(i));
    loglog(s/sxi, (1-p(i))^(-2)*nsp)
    legendInfo{i} = sprintf('p = %.2f', p(i));
    hold on;
end
legend(legendInfo);
xlabel('s');
ylabel('$(1-p)^{-2}n(s,p)$', 'Interpreter', 'latex');