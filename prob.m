clear;
clc;

p = (0.0:0.005:1.0);
nx = length(p);
N = 300;
%Lx = 2;
%Ly = 2;
L = [1 2 3 4];
P = zeros(length(L), nx);
Pi = zeros(length(L), nx);
legendInfo = cell(length(L), 1);
for j = 1:length(L)
Ni = zeros(nx,1);
Mi = zeros(nx,1);
for i = 1:N
    % generate new realization for each Ni
    z = rand(L(j),L(j));
    for ip = 1:nx
        m = z < p(ip);
        % finds clusters
        [lw,num] = bwlabel(m,4);
        % find spanning clusters
        top = lw(1,:);
        bottom = lw(L(j),:);
        left = lw(:,1);
        right = lw(:,L(j));
        tb = intersect(top,bottom);
        lf = intersect(left,right);
        sc = union(tb,lf);
        % remove the unoccupied cluster
        sc = sc(sc~=0);
        if ~isempty(sc);
            Ni(ip) = Ni(ip) + 1;
            for k = 1:length(sc)
                Mi(ip) = Mi(ip) + length(find(lw == sc(k)));
            end
        end
    end
end
legendInfo{j} = sprintf('L = %d', L(j));
Pi(j,:) = Ni/N;
P(j,:) = Mi/(N*L(j)^2);

% print progression
j
end

subplot(2,1,1)
hold on;
for i = 1:length(L)
    plot(p,Pi(i,:));
end
hold off;
xlabel('p', 'FontSize', 15)
ylabel('$\Pi(p,L)$', 'Interpreter', 'latex', 'FontSize', 15);
legend(legendInfo);

subplot(2,1,2)
hold on;
for i = 1:length(L)
    plot(p,P(i,:));
end
hold off;
xlabel('p', 'FontSize', 15)
ylabel('$P(p,L)$', 'Interpreter', 'latex', 'FontSize', 15);
legend(legendInfo);

