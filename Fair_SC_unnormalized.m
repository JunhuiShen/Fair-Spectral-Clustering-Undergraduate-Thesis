function clusterLabels = Fair_SC_unnormalized(adj,k,F)
%adjis the adjacency matrix of size n x n, k is number of clusters
%F is the matrix whose columns are f^{s}, s = 1, ..., h

n = size(adj, 1); l = size(F,2);
%compute the Laplacian matrix L
D = diag(sum(adj,2));
L = D - adj;

%F = f^{s} - |V_s|/n * 1_{n}
for i = 1:l
    F(:,i) =  F(:,i) - sum(F(:,i))/n  * ones(n,1);
end

%compute a matrix Z whose columns form an orthogonal basis of null(F^T)
Z = null(F');

%compute the k smallest eigenvalues of Z^{T} L Z
Msymm=Z'*L*Z;
Msymm=(Msymm+Msymm')/2;

% "smallestabs" and "smallestreal" both find the first k eigenvalues but 
%with different methods related to the Krylov method
% "MaxIterations" gives the maximum number of iterations
% "SubspaceDimension" gives the number of basis vectors
try
    [Y, eigValues] = eigs(Msymm,k,'smallestabs','MaxIterations',500,'SubspaceDimension',min(size(Msymm,1),max(2*k,25)));
catch
    [Y, eigValues] = eigs(Msymm,k,'smallestreal','MaxIterations',1000,'SubspaceDimension',min(size(Msymm,1),max(2*k,25)));
end

%apply k-means clusteirng to the rows of H = ZY
H = Z*Y;
clusterLabels = kmeans(H,k,'Replicates',10);
end