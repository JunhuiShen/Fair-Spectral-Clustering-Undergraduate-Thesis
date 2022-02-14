clear all
rng("default")
n = 1000;
v1 = [randn(n,2)*0.5+1];
v2 = [randn(n,2)*0.5];
X = [v1;v2];

epsilon = 0.8;k = 2;
adj = similarity(X,epsilon);
p = size(adj,1);

f1 = zeros(p,1); f1(1:1000)=1;
f2 = zeros(p,1); f2(1001:2000)=1;

F = [f1,f2];

% = Fair_SC_normalized(adj,k,F);
clusterLabels = Fair_SC_unnormalized(adj,k,F);
%clusterLabels = spectralcluster(X,k);


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


