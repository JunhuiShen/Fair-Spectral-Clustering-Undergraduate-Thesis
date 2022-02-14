[X,label] = twomoons(500);
epsilon = 0.3;k = 2;
S = similarity(X,epsilon);
n = size(S,1);
D = diag(sum(S,2));
D1 = diag(sum(S,2).^(-1/2));  %D^(-1/2)
L = D - S;
L_sym = D1 * L * D1;
[v,e] = eig(L_sym);
U = v(:,1:k);
T = zeros(n,k);
for i = 1: n
    for j = 1:k
        sum1 = sum((U(i,k)).^2);
        T(i,j) = U(i,j)/((sum1).^(1/2));
    end
end
idx1 = kmeans(T,k);

figure
gscatter(X(:,1),X(:,2),idx1,"rb");
legend("cluster 1","cluster 2")
title("spectral clustering using L_{sym}")

function [X,label] = twomoons(n) % Generate two moons, with n points in each moon.

% Specify the radius and relevant angles for the two moons.
noise = (1/6).*randn(n,1);
radius = 1 + noise;
angle1 = pi + pi/10;
angle2 = pi/10;

% Create the bottom moon with a center at (1,0).
bottomTheta = linspace(-angle1,angle2,n)';
bottomX1 = radius.*cos(bottomTheta) + 1;
bottomX2 = radius.*sin(bottomTheta);

% Create the top moon with a center at (0,0).
topTheta = linspace(angle1,-angle2,n)';
topX1 = radius.*cos(topTheta);
topX2 = radius.*sin(topTheta);

% Return the moon points and their labels.
X = [bottomX1 bottomX2; topX1 topX2];
label = [ones(n,1); 2*ones(n,1)];
end