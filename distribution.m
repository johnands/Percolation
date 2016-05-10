close all;
clear all;
clc;

% 1e6 random numbers, Z is a random variable
Z = rand(1e6,1).^(-3+1);

% cumulative distribution: must choose an upper limit
N = 100;

% z is the numbers we want to compare Z with
z = linspace(min(Z), 100, N);

% cumulative probability distribution
P = zeros(N, 1);

for i = 1:N
    % count the number of random numbers Z that are
    % larger than each value of z
    P(i) = sum(Z < z(i));
end

% normalize
P = P/1e6;

%plot(z, P)
%plot(log(z), log(P))

% find the distribution function, the derivative of the
% cumulative prob distribution
f = diff(P)/0.01;

x = z(1:end-1)';

subplot(3,2,1);
plot(x, f)
title('Distribution')
subplot(3,2,2)
loglog(x, f)
title('LogLog distribution')

polynomial = polyfit(log(x), log(f), 1);
fit = polyval(polynomial, log(x));

subplot(3,2,3)
plot(log(x), log(f))
hold on
plot(log(x), fit, 'o');
title('Polynomial fit');
alpha = polynomial(1)

a = 1.5;                                        % bin basis
logamax = ceil(log(max(f))/log(a));             % edge of last bin
bins = a.^(0:1:logamax);                        % all bin edges
histogram = histc(f, bins);                     % histogram
sizes = diff(bins);                             % bin sizes                    
centers = (bins(1:end-1) + bins(2:end))*0.5;    % bin centers
flog = histogram(1:end-1)'./sizes ;             % normalizing
subplot(3,2,4)
loglog(centers, flog, 'ob');
title('Histogram with logarithmic binning');

subplot(3,2,5)
hist(f, 100)
title('Ordinary histogram')


