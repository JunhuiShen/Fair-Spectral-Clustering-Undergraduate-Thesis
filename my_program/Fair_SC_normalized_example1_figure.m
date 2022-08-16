clear;

X = [0.6 0.4;
    0 -2;
    2.4 0;
    3.0 -1.5;
    1.6 1;
    1.5 -1.3;
    -0.2 0.6;
    1.9 -2.2];

c = [1 2 1 2 1 2 1 2];

epsilon = 2.8; k = 2;
adj = similarity(X,epsilon);

f1 = [1 0 1 0 1 0 1 0]';
F = [f1];
n = size(F,1); l = size(F,2);
for i = 1:l
    F(:,i) =  F(:,i) - sum(F(:,i))/n  * ones(n,1);
end

clusterLabels1 = Fair_SC_normalized(adj,k,F);
clusterLabels2 = spectralcluster(X,2);

figure
gscatter(X(:,1),X(:,2),c,"k","x*",[20 20])
X1 = X(:,1); X2 = X(:,2); 
hold on
scatter(X1(clusterLabels1 == 1), X2(clusterLabels1 == 1),400,"r","s",'LineWidth',4);
scatter(X1(clusterLabels1 == 2), X2(clusterLabels1 == 2),400,"b","o",'LineWidth',4);
lgd = legend("group 1","group 2","cluster 1","cluster 2");
lgd.FontSize = 12;
title1 = title("Normalized spectral clustering with group fairness constraints");
title1.FontSize = 18;
hold off


gscatter(X(:,1),X(:,2),c,"k","x*",[20 20])
hold on
X1 = X(:,1); X2 = X(:,2); 
scatter(X1(clusterLabels2 == 1), X2(clusterLabels2 == 1),400,"r","s",'LineWidth',4);
scatter(X1(clusterLabels2 == 2), X2(clusterLabels2 == 2),400,"b","o",'LineWidth',4);
lgd = legend("group 1","group 2","cluster 1","cluster 2");
lgd.FontSize = 12;
title2 = title("Normalized spectral clustering without group fairness constraints");
title2.FontSize = 17;
hold off

%print -depsc newfigure1