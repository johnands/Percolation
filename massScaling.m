close all;
clear all;
clc;

nL = 8;
L = zeros(nL,1);
for i = 1:nL;
    L(i) = 2^(i+3);
end
Mi = zeros(nL,1);
N = 300;
tic
for i = 1:N
    % generate new realization for each Ni   
    for j = 1:nL
        z = rand(L(j), L(j));
        m = z < L(j);
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
        % remove the zeros
        sc = sc(sc ~= 0);
        if length(sc) > 0;
            for k = 1:length(sc)
                Mi(j) = Mi(j) + length(find(lw==sc(k)));
            end
        end

    end
end

M = Mi/N;
loglog(L, M)
polynomial = polyfit(log(L), log(M), 1);
polynomial(1)