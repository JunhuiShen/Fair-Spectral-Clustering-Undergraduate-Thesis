rng("default")
k = 3;n =10000;
X = [randn(500,2)*0.75;randn(500,2)*0.5;randn(500,2)*0.65];

[idx,C] = mykmeans(X,k,n);

figure
gscatter(X(:,1),X(:,2),idx,"cgr");
hold on
plot(C(:,1),C(:,2),"kx")
legend("cluster 1","cluster 2","cluster 3","cluster centroid")
title("my k-means clustering")
hold off

print -depsc newfigure2


