clear;

rng("default")
n = 10;
v1 = [randn(n,2)*0.6+1.1];
v2 = [randn(n,2)*0.6-1.1];
X = [v1;v2];

epsilon = 2.8; k = 2;
adj = similarity(X,epsilon);
p = size(adj,1);

f1 = zeros(p,1); f1(1:n)=1;
f2 = zeros(p,1); f2(n+1:2*n)=1;
F = [f1,f2];

%clusterLabels = my_normalized_sc_rw(adj,k);
clusterLabels = Fair_SC_normalized(adj,k,F);

l1 = size(intersect(X(find(clusterLabels == 1),:),v1),1)/2;
l2 = size(intersect(X(find(clusterLabels == 1),:),v2),1)/2;

m1 = size(intersect(X(find(clusterLabels == 2),:),v1),1)/2;
m2 = size(intersect(X(find(clusterLabels == 2),:),v2),1)/2;

c1 = size(find(clusterLabels == 1),1);
c2 = size(find(clusterLabels == 2),1);

fprintf("|V1|/|V| = %.2f, and |V2|/|V| = %.2f \n",n/(2*n),n/(2*n))

fprintf("|V1 cap C1|/|C1| = %.2f , and |V2 cap C1|/|C1| = %.2f \n",l1/c1, l2/c1)
fprintf("|V1 cap C2|/|C2| = %.2f, and  |V2 cap C2|/|C2| = %.2f", m1/c2, m2/c2)
