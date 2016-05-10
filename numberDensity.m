close all;
clear all;
clc;

M = 300;       % number of realizations / measurements
L = 200;
p = [0.54 0.55 0.56 0.57 0.58 0.59];
pc = 0.59275;      % percolation treshold
allarea = [];      % areas of all clusters sampled M times
legendInfo = cell(length(p), 1);
for j = 1:length(p)
    for i = 1:M
        z = rand(L,L);
        m = z < p(j);
        % lw: each occupied site is given an index that says
        % which cluster it belongs to
        [lw, num] = bwlabel(m,4);
        
        % find and remove spanning cluster
        top = lw(1,:);
        bottom = lw(L,:);
        left = lw(:,1);
        right = lw(:,L);
        tb = intersect(top,bottom);
        lf = intersect(left,right);
        sc = union(tb,lf);
        % remove sites that are not part of clusters
        % sc now contains the indicies of eventual spanning clusters
        sc = sc(sc~=0);
        if ~isempty(sc);
            for k = 1:length(sc);
                % remove spanning clusters
                %length(sc)
                lw = lw(lw ~= sc(k));
            end
        end
        
        % find distribution of cluster sizes
        s = regionprops(lw, 'Area');
        % area contains number of sites in all clusters
        area = cat(1, s.Area);
        allarea = cat(1, allarea, area);
    end
    % logarithmic binning
    % n: vector of number of elements in each bin
    % s: location of all bin centers
    [n,s] = hist(allarea, L^2);
    a = 1.2;                                % basis for logartithmic bins
    logamax = ceil(log(max(s)) / log(a));   % edge of largest bin
    bins = a.^(0:1:logamax);                % bin edges
    nl = histc(allarea, bins);              % histogram with new bins
    ds = diff(bins);                        % bin sizes
    sl = (bins(1:end-1) + bins(2:end))*0.5; % bin centers
    nsl = nl(1:end-1)'./(M*L^2*ds);         % cluster number density
    legendInfo{j} = sprintf('p = %.2f', p(j));
    loglog(sl, nsl);
    hold on;
    
    % print progression
    j
end
legend(legendInfo);
xlabel('$$ \mathrm{log_{10}}\, s $$', 'Interpreter', 'latex');
ylabel('$$ \mathrm{log_{10}}\, n(s,p) $$', 'Interpreter', 'latex');

% plot intersection line
sl = sl(nsl~=0);
nsl = nsl(nsl~=0);
poly = polyfit(log(sl), log(nsl), 1);
intersection = poly(2)*sl.^(poly(1));
loglog(sl, intersection, 'k--');
hold off;


