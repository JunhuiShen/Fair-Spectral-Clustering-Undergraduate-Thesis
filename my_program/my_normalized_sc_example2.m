clear all
[X,label] = twomoons(500);
epsilon = 0.3;k = 2;
S = similarity(X,epsilon);
idx1 = my_normalized_sc_sym(S,k);

figure
gscatter(X(:,1),X(:,2),idx1,"rb");
legend("cluster 1","cluster 2")
title("spectral clustering using L_{sym}")

%print -depsc newfigure5