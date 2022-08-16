N = 800; 
r1 = 2; r2 = 4; 
theta = linspace(0,2*pi,N)';

X1 = r1*[cos(theta),sin(theta)]+ rand(N,1); 
X2 = r2*[cos(theta),sin(theta)]+ rand(N,1);
X = [X1;X2];

%run the k-means algorithm
k=2; n = 1000;
[idx,C] = mykmeans(X,k,n);

ax1 = subplot(2,1,1); 
gscatter(X(:,1),X(:,2),idx,"gc");
hold on
plot(C(:,1),C(:,2),"kx")
legend("cluster 1","cluster 2", "cluster centroid")
title(ax1,"k-means clustering")
idx1 = spectralcluster(X,2); 
%we use spectral clustering to cluster
ax2 = subplot(2,1,2); 
gscatter(X(:,1),X(:,2),idx1,"gc");
legend("cluster 1","cluster 2")
title(ax2, "Spectral clustering")

print -depsc newfigure1