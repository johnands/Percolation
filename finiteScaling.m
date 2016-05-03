close all;
clear all;
clc;

L = [25 50 100 200 400 800];
nL = length(L);
p = linspace(0.5, 0.7, 50);
np = length(p);
Ni = zeros(nL,np);
N = 300;
tic
for i = 1:N
    for j = 1:nL
        for k = 1:np
            % generate new realization for each Ni
            z = rand(L(j), L(j));
            m = z < p(k);
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
            if ~isempty(sc);
                Ni(j,k) = Ni(j,k) + 1;
            end
        end
    end
    
    % print progress
    if mod(i,10) == 0
        i
    end      
end
toc

PI = Ni/N;
legendInfo = cell(nL,1);
for i = 1:nL   
    plot(p, PI(i,:))
    legendInfo{i} = sprintf('L = %d', L(i));
    hold on;
end
legend(legendInfo);
xlabel('p')
ylabel('$\Pi$', 'Interpreter', 'Latex')
title('Percolation probability')