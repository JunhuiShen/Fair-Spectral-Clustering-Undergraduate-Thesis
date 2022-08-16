clear;

X = [-2 2; -2 0; -2 -2; -2 -4 ;0 2; 0 0; 0 -2; 0 -4];

epsilon = 5; k = 2;
adj = similarity(X,epsilon);

R = [0 1 0 0 1 0 0 0;
    1 0 0 0 0 1 0 0;
    0 0 0 0 0 0 0 0;
    0 0 0 1 0 0 1 0;
    1 0 0 0 0 1 0 0;
    0 1 0 0 1 0 0 0;
    0 0 0 1 0 0 1 0;
    0 0 0 0 0 0 0 0];
J = eye(8) - 1/8 * ones(8,1) * ones(1,8);
RJ = R * J;

clusterLabels1 = Fair_SC_normalized_individual(adj,k, RJ);

%clusterLabels2 = spectralcluster(X,2);


figure
hold on
X1 = X(:,1); X2 = X(:,2);
scatter(X1(clusterLabels1 == 1), X2(clusterLabels1 == 1),400,"r","s",'LineWidth',4);
scatter(X1(clusterLabels1 == 2), X2(clusterLabels1 == 2),400,"b","o",'LineWidth',4);
lgd = legend("cluster 1","cluster 2");
lgd.FontSize = 12;
title2 = title("Normalized spectral clustering with individual fairness constraints");
title2.FontSize = 15;
hold off

%{
figure
hold on
X1 = X(:,1); X2 = X(:,2); 
scatter(X1(clusterLabels2 == 1), X2(clusterLabels2 == 1),400,"r",'LineWidth',4);
scatter(X1(clusterLabels2 == 2), X2(clusterLabels2 == 2),400,"b",'LineWidth',4);
lgd = legend("cluster 1","cluster 2");
lgd.FontSize = 12;
title2 = title("Normalized spectral clustering without individual fairness constraints");
title2.FontSize = 15;
hold off
%}

print -depsc newfigure3