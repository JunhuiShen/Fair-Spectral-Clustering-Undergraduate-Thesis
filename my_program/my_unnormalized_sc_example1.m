rng("default")
[X,label] = twomoons(500);
epsilon = 0.3;k = 2;

S = similarity(X,epsilon);
idx1 = my_unnormalized_sc(S,k);

figure
gscatter(X(:,1),X(:,2),idx1,"rb");
legend("cluster 1","cluster 2","cluster 3")
title("unnormalized spectral clustering")

print -depsc newfigure