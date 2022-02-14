clear all
rng("default")
n = 500;
[X,label] = twomoons(n);
v1 = [X(1:200,:);X(501:600,:)];
v2 = [X(201:500,:);X(601:1000,:)];

epsilon = 0.3;k = 2;
adj = similarity(X,epsilon);

p = size(adj,1);
f1 = zeros(p,1); f1(1:200)=1; f1(501:600)=1;
f2 = zeros(p,1); f2(201:500)=1; f2(601:1000)=1; 
F = [f1,f2];

%clusterLabels = my_unnormalized_sc(adj,k);
clusterLabels = Fair_SC_unnormalized(adj,k,F);
%clusterLabels = Fair_SC_normalized(adj,k,F);

l1 = size(intersect(X(find(clusterLabels == 1),:),v1),1)/2;
l2 = size(intersect(X(find(clusterLabels == 1),:),v2),1)/2;
m1 = size(intersect(X(find(clusterLabels == 2),:),v1),1)/2;
m2 = size(intersect(X(find(clusterLabels == 2),:),v2),1)/2;
c1 = size(find(clusterLabels == 1),1);
c2 = size(find(clusterLabels == 2),1);
fprintf("The balance of V = %.4f \n", min(sum(f1)/p,sum(f2)/p))
fprintf("balance of c1 = %.4f \n", min(l1/c1,l2/c1))
fprintf("balance of c2 = %.4f \n", min(m1/c1,m2/c1))
fprintf("Therefore, balance of C = %.4f", min(min(l1/c1,l2/c1),min(m1/c1,m2/c1)))

figure
gscatter(X(:,1),X(:,2),clusterLabels,"rb");
legend("cluster 1","cluster 2")
title("spectral clustering")

function [X,label] = twomoons(n) % Generate two moons, with n points in each moon.

% Specify the radius and relevant angles for the two moons.
noise = (1/6).*randn(n,1);
radius = 1+noise;
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


