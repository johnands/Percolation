close all;
clear all;
clc;

M = 1000;       % number of realizations / measurements
L = [25 50 100 200 400 800];
pc = 0.59275;      % percolation treshold
D = 91.0/48.0;
tau = 187.0/91.0;
allarea = [];      % areas of all clusters sampled M times
legendInfo = cell(length(L), 1);
for j = 1:length(L)
    for i = 1:M
        z = rand(L(j),L(j));
        m = z < pc;
        % lw: each occupied site is given an index that says
        % which cluster it belongs to
        [lw, num] = bwlabel(m,4);
        
        % find and remove spanning cluster
        top = lw(1,:);
        bottom = lw(L(j),:);
        left = lw(:,1);
        right = lw(:,L(j));
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
    [n,s] = hist(allarea, L(j)^2);
    max(s)
    a = 1.5;                                % basis for logartithmic bins
    logamax = ceil(log(max(s)) / log(a));   % edge of largest bin
    bins = a.^(0:1:logamax);                % bin edges
    nl = histc(allarea, bins);              % histogram with new bins
    ds = diff(bins);                        % bin sizes
    sl = (bins(1:end-1) + bins(2:end))*0.5; % bin centers
    nsl = nl(1:end-1)'./(M*L(j)^2*ds);         % cluster number density
    legendInfo{j} = sprintf('L = %d', L(j));
    loglog(sl.*L(j)^(-D), nsl.*sl.^tau, 'LineWidth', 2);
    hold on;
    
    % print progression
    j
end
h_legend = legend(legendInfo, 'Location', 'southwest');
set(h_legend, 'FontSize', 18);
xlabel('$sL^{-D}$', 'Interpreter', 'latex', 'FontSize', 20);
ylabel('$s^{\tau}n(s,p_c,L)$', 'Interpreter', 'latex', 'FontSize', 20);
title('Data collapse for finite scaling of cluster number density', 'FontSize', 18);

