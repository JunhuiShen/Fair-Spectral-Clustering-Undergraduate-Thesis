function clusterLabels = Fair_SC_normalized(adj,k,F)
%adjis the adjacency matrix of size n x n
%k is number of clusters
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

%compute the principal square root Q of Z' D Z
Q=sqrtm(Z'*D*Z);

%compute the first k eigenvectors of Q^(-1)*Z^T*L*Z*Q^(-1)
Qinv=inv(Q);
Msymm=Qinv'*Z'*L*Z*Qinv;
Msymm=(Msymm+Msymm')/2;

% "smallestabs" and "smallestreal" both find the first k eigenvalues but with
%different methods related to the Krylov method
% "maxiterations" gives the maximum number of iterations
% "SubspaceDimension" gives the number of basis vectors

try
    [Y, eigValues] = eigs(Msymm,k,'smallestabs','MaxIterations',500,'SubspaceDimension',min(size(Msymm,1),max(2*k,25)));
catch
    [Y, eigValues] = eigs(Msymm,k,'smallestreal','MaxIterations',1000,'SubspaceDimension',min(size(Msymm,1),max(2*k,25)));
end

%apply k-means clusteirng to the rows of H = Z Q^(-1) Y
%Y is a matrix containing these eigenvectors
H = Z*Qinv*Y;
clusterLabels = kmeans(H,k,'Replicates',10);
end