close all;
clear all;
clc;

p = (0.3:0.01:1.0);
nx = length(p);
Mi = zeros(nx,1);
Ni = zeros(nx,1);
N = 50;
Lx = 100;
Ly = 100;
tic
for i = 1:N
    % generate new realization for each Ni
    z = rand(Lx, Ly);
    for ip = 1:nx
        m = z < p(ip);
        % finds clusters
        [lw,num] = bwlabel(m,4);
        
%         % METHOD 1
%         % finds bounding boxes, s is a struct array
%         s = regionprops(lw, 'BoundingBox');
%         % extract the bounding boxes from s
%         bbox = cat(1, s.BoundingBox);
%         % find area (number of sites) in each cluster
%         s = regionprops(lw, 'Area');
%         % extract area from s
%         area = cat(1, s.Area);
%         % find spanning clusters in x and y-direction seperately
%         jx = find(bbox(:,3) == Ly);
%         jy = find(bbox(:,4) == Lx);
%         % combine jx and jy without repetitions
%         % (one cluster can span in both directions)
%         j = union(jx, jy);
%         if (length(j) > 0) % percolation
%             Ni(ip) = Ni(ip) + 1;
%             for jj = 1:length(j)
%                 % add masses of all percolation clusters
%                 Mi(ip) = Mi(ip) + area(j(jj));
%             end
%         end
        
        % METHOD 2 
        top = lw(1,:);
        bottom = lw(Lx,:);
        left = lw(:,1);
        right = lw(:,Ly);       
        % check whether the same cluster is at opposite ends of grid
        tb = intersect(top, bottom);
        lf = intersect(left, right);
        % don't want to count the same cluster twice
        sc = union(tb,lf);
        % remove the zeros
        sc = sc(sc ~= 0);
        if length(sc) > 0;
            Ni(ip) = Ni(ip) + 1;
            for j = 1:length(sc)
                Mi(ip) = Mi(ip) + length(find(lw==sc(j)));
            end
        end

    end
end
toc


PI = Ni/N;
P = Mi/(N*Lx*Ly);

% subplot(2,1,1)
% plot(p,PI);
% xlabel('p')
% ylabel('\Pi')
% text = sprintf('(Lx,Ly) = (%d,%d)', [Lx, Ly]);
% title(text)
% 
% subplot(2,1,2)
% plot(p,P);
% xlabel('p');yg
% ylabel('P');


pc = 0.59275;
p2 = p > pc;
p = p(p2) - pc;
P = P(p2);

x = log(p');
y = log(P);

polynomial = polyfit(x, y, 1);
fit = polyval(polynomial, x);

plot(x, y);
hold on
plot(x, fit, 'o');






