% close all;
% clear all;
% clc;
% 
% M = 300;       % number of realizations / measurements
% L = zeros(7,1);
% for i = 1:length(L);
%     L(i) = 2^(i+3);
% end
% pc = 0.59275;      % percolation treshold
% allarea = [];      % areas of all clusters sampled M times
% legendInfo = cell(length(L), 1);
% coeff = zeros(length(L), 2);  % polynomial fit for all L
% for j = 1:length(L)
%     for i = 1:M
%         z = rand(L(j),L(j));
%         m = z < pc;
%         % lw: each occupied site is given an index that says
%         % which cluster it belongs to
%         [lw, num] = bwlabel(m,4);
%         
%         % find and remove spanning cluster
%         top = lw(1,:);
%         bottom = lw(L(j),:);
%         left = lw(:,1);
%         right = lw(:,L(j));
%         tb = intersect(top,bottom);
%         lf = intersect(left,right);
%         sc = union(tb,lf);
%         % remove sites that are not part of clusters
%         % sc now contains the indicies of eventual spanning clusters
%         sc = sc(sc~=0);
%         if ~isempty(sc) > 0;
%             for k = 1:length(sc);
%                 % remove spanning clusters
%                 lw = lw(lw~=sc(k));
%             end
%         end
%         
%         % find distribution of cluster sizes
%         s = regionprops(lw, 'Area');
%         % area contains number of sites in all clusters
%         area = cat(1, s.Area);
%         allarea = cat(1, allarea, area);
%     end
%     % logarithmic binning
%     % n: vector of number of elements in each bin
%     % s: location of all bin centers
%     [n,s] = hist(allarea, L(j)^2);
%     a = 1.2;                                % basis for logartithmic bins
%     logamax = ceil(log(max(s)) / log(a));   % edge of largest bin
%     bins = a.^(0:1:logamax);                % bin edges
%     nl = histc(allarea, bins);              % histogram with new bins
%     ds = diff(bins);                        % bin sizes
%     sl = (bins(1:end-1) + bins(2:end))*0.5; % bin centers
%     nsl = nl(1:end-1)'./(M*L(j)^2*ds);      % cluster number density
%     legendInfo{j} = sprintf('L = %d', L(j));
%     loglog(sl, nsl);
%     hold on;
%     % remove zeros
%     sl = sl(nsl~=0);
%     nsl = nsl(nsl~=0);   
%     % find tau
% %     polynomial = polyfit(log(sl), log(nsl), 1); 
% %     coeff(j,1) = polynomial(1);
% %     coeff(j,2) = polynomial(2);  
%     
%     % print progression
%     j
% end
% 
% legend(legendInfo);
% xlabel('$$ \mathrm{log_{10}}\, s $$', 'Interpreter', 'latex');
% ylabel('$$ \mathrm{log_{10}}\, n(s,p) $$', 'Interpreter', 'latex');
% 
% % find tau as polyfit for largest L
% polynomial = polyfit(log(sl), log(nsl), 1); 
% tau = -polynomial(1);

% plot intersection line
intersection = 10^(-2)*sl.^(-tau);
loglog(sl, intersection, 'k--')

% find average tau for all L
% tau = -sum(coeff(:,1))/length(coeff(:,1));
% constant = sum(coeff(:,2))/length(coeff(:,2));
% intersectLine = 10^constant*sl.^(-tau);
% loglog(sl, intersectLine, 'k--');
% hold off;

% [fit, gof] = createFit( sl(5:floor(end/2)), nsl(5:floor(end/2))*10^(-0.5) );
% coeffvalues(fit)
% c = coeffvalues(fit);
% 
% fit = c(1)*sl.^c(2);
% loglog(sl, fit, 'k--')
% hold off;