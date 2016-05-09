% exwalk.m
% Example of use of the walk routine
% Generate spanning cluster (l-r spanning)
lx = 64;
ly = 64;
p = 0.585;
ncount = 0;
perc = [];
while (size(perc,1)==0)
    ncount = ncount + 1;
    if (ncount>1000)
        return
    end
    z = rand(lx,ly) < p;
    [lw,num] = bwlabel(z,4);
    % percolating clusters?
    perc_x = intersect(lw(1,:), lw(lx,:));
    % find eventual percolating clusters, the loop then stops
    perc = find(perc_x > 0)
end

s = regionprops(lw,'Area');
clusterareas = cat(1,s.Area);
% size of percolating cluster (cluster with most sites)
maxarea = max(clusterareas);
% index of cluster with max number of sites / spanning cluster
i = find(clusterareas == maxarea);
% find "coordinates" of all sites in spanning cluster
zz = lw == i;
% zz now contains the spanning cluster
imagesc(zz); % Display spanning cluster
% Run walk on this cluster
[l,r] = walk(zz);
% find points where both l and r are non-zero, i.e singly connected bonds
% some of these have value 1, i.e. the site have been visited once
% by each walker. If value 2, then one of the walkers have visited the
% singly-connected site twice. If 4, then both walkers have visited the
% same singly-connected site twice.
zzz = l.*r;
% add percolating cluster and singly connected bonds
% the sites corresponding to singly connected bonds will
% have value 2, 3 or 5, the others that are part of the cluster 
% will be 1
zadd = zz + zzz;
max(max(zadd))
% percolating cluster
subplot(2,2,1), imagesc(zz);
title('Percolating cluster');
% percolating cluster and singly connected bonds
% the singly connected bonds will be coloured differently
subplot(2,2,2), imagesc(zadd);
title('Percolating cluster and singly connected bonds');
% only singly connected bonds
subplot(2,2,3), imagesc(zzz > 0);
title('Singly connected bonds')
% external perimeter
subplot(2,2,4), imagesc(l+r > 0);
title('External perimeter')


    
    