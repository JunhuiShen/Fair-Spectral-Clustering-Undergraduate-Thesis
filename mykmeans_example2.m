t = linspace(0,2*pi,100); 
%we build the concentric circles
x1 = 1 * cos(t);
y1 = 1 * sin(t);
x2 = 2 * cos(t);
y2 = 2 * sin(t);
X = [x1', y1';x2', y2'];

%run the k-means algorithm
k=2; n = 1000;
[idx,C] = mykmeans(X,k,n);

figure
gscatter(X(:,1),X(:,2),idx,"cy");
hold on
plot(C(:,1),C(:,2),"kx")
legend("cluster 1","cluster 2", "cluster centroid")
title("figure 9")
idx1 = spectralcluster(X,2); 
%we use spectral clustering to cluster
figure
gscatter(X(:,1),X(:,2),idx1,"cy");
legend("cluster 1","cluster 2")
title("figure 10")