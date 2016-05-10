close all;
clear all;
clc;

pc = 0.59275;
p = pc:0.01:0.7;
np = length(p);
N = 200;
Mi = zeros(np,1);
L = 100;

for i = 1:N
    % generate new realization for each Ni   
    for j = 1:np
        % generate percolating cluster
        % walk algorithm only works if we have percolation
        ncount = 0;
        perc = [];
        while (size(perc,1) < 1)
            ncount = ncount + 1;
            if (ncount > 1000)
                return
            end
            z = rand(L, L);
            m = z < p(j);
            [lw,num] = bwlabel(m,4);
            % percolating clusters in x-direction
            perc_x = intersect(lw(1,:), lw(L,:));
            % stop loop if percolation
            perc = find(perc_x > 0);     
        end
        
        % choose the last percolating cluster
        zz = lw == perc_x(end);
        % run walk on this cluster
        [l,r] = walk(zz);
        % find singly connected bonds, i.e. sites which both
        % walkers have visited
        zzz = l.*r;
        % find mass of singly connected bonds
        Mi(j) = Mi(j) + length(find(zzz));
    end
    
    % print progression
    if mod(i,10) == 0
        i
    end
end

P = Mi./(N*L^2);
subplot(2,1,1)
plot(p-pc, P);
xlabel('$p-p_c$', 'Interpreter', 'Latex', 'FontSize', 14);
ylabel('$P_{SC}$', 'Interpreter', 'Latex', 'FontSize', 14);
title('Density of singly connected bonds')
axis('square')
subplot(2,1,2)
loglog(p-pc, P);
xlabel('$p-p_c$', 'Interpreter', 'Latex', 'FontSize', 14);
ylabel('$P_{SC}$', 'Interpreter', 'Latex', 'FontSize', 14);
title('Logarithmic plot');
axis('square')
