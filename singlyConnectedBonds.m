close all;
clear all;
clc;

% part 1
% nL = 7;
% L = zeros(nL,1);
% for i = 1:nL;
%     L(i) = 2^(i+3);
% end
% Mi = zeros(nL,1);

% part 2


for i = 1:N
    % generate new realization for each Ni   
    for j = 1:nL
        % generate percolating cluster
        % walk algorithm only works if we have percolation
        ncount = 0;
        perc = [];
        while (size(perc,1) < 1)
            ncount = ncount + 1;
            if (ncount > 1000)
                return
            end
            z = rand(L(j), L(j));
            m = z < pc;
            [lw,num] = bwlabel(m,4);
            % percolating clusters in x-direction
            perc_x = intersect(lw(1,:), lw(L(j),:));
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
    if mod(i,2) == 0
        i
    end
end

M = Mi/N;
loglog(L, M, 'b--o');
polynomial1 = polyfit(log(L), log(M), 1);
polynomial2 = polyfit(L, M, 1);
polynomial1(1)
fit = polyval(polynomial2, L);
legend('Measurements')
xlabel('L', 'FontSize', 14);
ylabel('$M_{SC}$', 'Interpreter', 'Latex', 'FontSize', 14);
title('Mass of singly connected bonds')

