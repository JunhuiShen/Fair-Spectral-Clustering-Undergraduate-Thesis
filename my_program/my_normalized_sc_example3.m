rng("default");
X = [randn(1000,2)*0.75+ones(1000,2);randn(1000,2)*0.5-ones(1000,2);randn(1000,2)*0.75];
epsilon = 1;k = 3;
S = similarity(X,epsilon);
D = diag(sum(S,2));
L = D - S;
[v1, e1] = eig(L,D);
U1 = v1(:,1:k);idx1 = kmeans(U1,k);

[v2, e2] = eig(L);
U2 = v2(:,1:k);
idx2 = kmeans(U2,k);

ax1 = subplot(2,1,1); 
gscatter(X(:,1),X(:,2),idx1,"rgb");
legend("cluster 1","cluster 2","cluster 3")
title(ax1,"Normalized spectral clustering")

ax2 = subplot(2,1,2); 
gscatter(X(:,1),X(:,2),idx2,"rgb");
legend("cluster 1","cluster 2","cluster 3")
title(ax2,"Unnormalized spectral clustering")

print -depsc newfigure4