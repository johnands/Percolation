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
tic
for i = 1:N
    % generate new realization for each Ni   
    for j = 1:nL
        z = rand(L(j), L(j));
        m = z < pc;
        % finds clusters
        [lw,num] = bwlabel(m,4);
        
        % METHOD 2 
        top = lw(1,:);
        bottom = lw(L(j),:);
        left = lw(:,1);
        right = lw(:,L(j));       
        % check whether the same cluster is at opposite ends of grid
        tb = intersect(top, bottom);
        lf = intersect(left, right);
        % don't want to count the same cluster twice
        sc = union(tb,lf);
        if ~isempty(sc);
            for k = 1:length(sc)
                % add masses of all percolating clusters
                % find makes sure the zeros doesn't count
                Mi(j) = Mi(j) + length(find(lw == sc(k)));
            end
        end
    end
end

M = Mi/N;
loglog(L, M)
polynomial = polyfit(log(L), log(M), 1);
polynomial(1)