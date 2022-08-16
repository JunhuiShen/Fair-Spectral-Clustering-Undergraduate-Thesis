function idx1 = my_normalized_sc_rw(S,k)
D = diag(sum(S,2));
L = D - S;
[v, e] = eig(L,D);
U = v(:,1:k);
idx1 = kmeans(U,k);
end