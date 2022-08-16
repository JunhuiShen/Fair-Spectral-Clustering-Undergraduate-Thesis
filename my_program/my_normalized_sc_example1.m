clear all
[X,label] = twomoons(500);
epsilon = 0.3;k = 2;

S = similarity(X,epsilon);

D = diag(sum(S,2));
L = D - S;
[v, e] = eig(L,D);
U = v(:,1:k);
idx1 = kmeans(U,k);

figure
gscatter(X(:,1),X(:,2),idx1,"rb");
legend("cluster 1","cluster 2")
title("spectral clustering using L_{rw}")

print -depsc newfigure3