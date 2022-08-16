function clusterLabels = Fair_SC_normalized_individual(adj,k,RJ)
% RJ = R * J
D = diag(sum(adj,2));
L = D - adj;

[U, S, V] = svd(RJ);
r = rank(RJ);
F = sqrt(S) * V'; F = F(1:r, :)';

Z = null(F');

Q=sqrtm(Z'*D*Z);

Qinv=inv(Q);
Msymm=Qinv'*Z'*L*Z*Qinv;
Msymm=(Msymm+Msymm')/2;

[Y, eigValues] = eigs(Msymm,k);

H = Z*Qinv*Y;
clusterLabels = kmeans(H,k,'Replicates',10);
end