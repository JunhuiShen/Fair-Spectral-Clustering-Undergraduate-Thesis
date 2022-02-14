function idx1 = my_unnormalized_sc(S,k)
D = diag(sum(S,2));
L = D - S;
[v,e] = eig(L);
U = v(:,1:k);
idx1 = kmeans(U,k);
end