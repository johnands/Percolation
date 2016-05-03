% close all;
% clear all;
% clc;
% 
% L = [25 50 100 200 400 800];
% nL = length(L);
% p = 0.59275;    
% Ni = zeros(nL,1);               % number of percolating clusters
% N = 100;                        % number of system realizations
% n = 10;                         % number of algo iterations
% step = 0.1;                     % step length
% x = [0.3 0.8];                  % values of Pi
% pList = zeros(nL,length(x));    % store p for each L and x
% tic
% for i = 1:nL
%     for j = 1:length(x)
%         % reset values of p and step before next x
%         p = 0.59275;    
%         step = 0.1;
%         for k = 1:n
%             Ni(i) = 0;
%             for l = 1:N
%                 % generate new realization for each Ni
%                 z = rand(L(i), L(i));
%                 m = z < p;
%                 % finds clusters
%                 [lw,num] = bwlabel(m,4);
%         
%                 % METHOD 2 
%                 top = lw(1,:);
%                 bottom = lw(L(i),:);
%                 left = lw(:,1);
%                 right = lw(:,L(i));       
%                 % check whether the same cluster is at opposite ends of grid
%                 tb = intersect(top, bottom);
%                 lf = intersect(left, right);
%                 % don't want to count the same cluster twice
%                 sc = union(tb,lf);
%                 % remove the zeros
%                 sc = sc(sc ~= 0);
%                 if ~isempty(sc);
%                     Ni(i) = Ni(i) + 1;
%                 end
%             end
%             Pi = Ni(i)/N;
%             % check value
%             if Pi > x(j)
%                 p = p - step;
%             else
%                 p = p + step;
%             end
%             step = step/2.0;
%         end
%         pList(i,j) = p;
%     end   
%     
%     % print progress
%     i
%     
% end
% toc

% ---------- problem i ----------
% legendInfo = cell(length(x),1);
% for i = 1:length(x)   
%     plot(L, pList(:,i), '--o')
%     legendInfo{i} = sprintf('p_{\\Pi=x} = %.1f', x(i));
%     hold on;
% end
% legend(legendInfo, 'FontSize', 12);
% xlabel('L', 'FontSize', 12)
% ylabel('p', 'FontSize', 12)
% hold off;

% --------- problem j ----------
% dp = pList(:,2) - pList(:,1);
% loglog(L, dp);
% xlabel('L', 'FontSize', 12);
% ylabel('p', 'FontSize', 12);
% title('$p_{\Pi=0.8} - p_{\Pi=0.3}$', 'Interpreter', 'Latex', 'FontSize', 15);
% 
% % find slope = vu
% poly = polyfit(log(L'), log(dp), 1);
% vu = -1.0/poly(1)

% ---------- problem k ----------
vu_exact = 4.0/3.0;
Lnu = L.^(-1.0/vu_exact);

legendInfo = cell(4,1);
plot(Lnu, pList(:,1), '-o');
legendInfo{1} = sprintf('p_{\\Pi=x} = %.1f', x(1));
hold on;
plot(Lnu, pList(:,2), '-o');
legendInfo{3} = sprintf('p_{\\Pi=x} = %.1f', x(2));

% "extrapolate" to the y-axis
poly03 = polyfit(Lnu', pList(:,1), 1);
poly08 = polyfit(Lnu', pList(:,2), 1);

L_extra = linspace(0, 0.09, 100);
fit03 = poly03(1)*L_extra + poly03(2);
fit08 = poly08(1)*L_extra + poly08(2);

plot(L_extra, fit03, '--')
plot(L_extra, fit08, '--')
legendInfo{2} = sprintf('Fit p_{\\Pi=x} = %.1f', x(1));
legendInfo{4} = sprintf('Fit p_{\\Pi=x} = %.1f', x(2));
legend(legendInfo, 'Location', 'NorthWest');
xlabel('L', 'FontSize', 12);
ylabel('p', 'FontSize', 12);
hold off;

pc1 = fit03(1)
pc2 = fit08(1)

