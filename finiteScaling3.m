% close all;
% clear all;
% clc;
% 
% L = [25 50 100 200];
% nL = length(L);
% p = linspace(0.5, 0.7, 50);
% np = length(p);
% pc = 0.59275;    
% Ni = zeros(nL,np);      % number of percolating clusters
% N = 100;                % number of system realizations
% 
% tic
% for i = 1:N
%     for j = 1:nL
%         for k = 1:np
%             % generate new realization for each Ni
%             z = rand(L(j), L(j));
%             m = z < p(k);
%             % finds clusters
%             [lw,num] = bwlabel(m,4);
%         
%             % METHOD 2 
%             top = lw(1,:);
%             bottom = lw(L(j),:);
%             left = lw(:,1);
%             right = lw(:,L(j));       
%             % check whether the same cluster is at opposite ends of grid
%             tb = intersect(top, bottom);
%             lf = intersect(left, right);
%             % don't want to count the same cluster twice
%             sc = union(tb,lf);
%             % remove the zeros
%             sc = sc(sc ~= 0);
%             if ~isempty(sc);
%                 Ni(j,k) = Ni(j,k) + 1;
%             end
%         end
%     end
%     
%     % print progress
%     if mod(i,10) == 0
%         i
%     end      
% end
% toc

pc = 0.59275;
vu = 4/3;
ppc = p-pc;
Lvu = L.^(1/vu);

%PI = Ni/N;
legendInfo = cell(nL,1);
for i = 1:nL   
    plot(ppc*L(i)^(1/vu), PI(i,:))
    legendInfo{i} = sprintf('L = %d', L(i));
    hold on;
end
legend(legendInfo);
xlabel('$(p-p_c)L^{1/\mu}$', 'Interpreter', 'Latex')
ylabel('$\Pi$', 'Interpreter', 'Latex')
title('Percolation probability data collapse')