close all;
clear all;
clc;

nL = 5;
L = zeros(nL,1);
for i = 1:nL;
    L(i) = 2^(i+3);
end
Mi = zeros(nL,1);
N = 10;
pc = 0.59275;

for i = 1:N
    % generate new realization for each Ni   
    for j = 1:nL
        % generate percolating cluster
        % walk algorithm only works if we have percolation
        ncount = 0;
        perc = [];
        while (size(perc,1) == 0)
            ncount = ncount + 1;
            if (ncount > 1000)
                return
            end
            z = rand(L(j), L(j));
            m = z < pc;
            [lw,num] = bwlabel(m,4);
            % percolating clusters?
            perc_x = intersect(lw(1,:), lw(L(j),:));
            perc_y = intersect(lw(:,1), lw(:,L(j)));
            % find eventual percolating clusters, the loop then stops
            perc = find(union(perc_x, perc_y) > 0);          
        end
        s = regionprops(lw,'Area');
        % mass / area / number of sites for each cluster
        clusterareas = cat(1,s.Area);
        % size of percolating cluster (cluster with most sites)
        maxarea = max(clusterareas);
        % index of cluster with max number of sites / spanning cluster
        index = find(clusterareas == maxarea);
        % find "coordinates" of all sites in spanning cluster
        zz = lw == index;
        % run walk on this cluster
        [l,r] = walk(zz);
        % find singly connected bonds, i.e. sites which both
        % walkers have visited
        zzz = l.*r;
        % find mass of singly connected bonds
        Mi(j) = Mi(j) + length(find(zzz));   
    end
    
    % print progression
    if mod(i,2) == 0
        i
    end
end

M = Mi/N;
loglog(L, M);
polynomial = polyfit(log(L), log(M), 1);
polynomial(1)