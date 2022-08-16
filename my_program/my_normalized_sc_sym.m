function idx1 = my_normalized_sc_sym(S,k)
n = size(S,1);
D = diag(sum(S,2));
D1 = diag(sum(S,2).^(-1/2));  %D^(-1/2)
L = D - S;
L_sym = D1 * L * D1;
[v,~] = eig(L_sym);
U = v(:,1:k);
T = zeros(n,k);
for i = 1: n
    for j = 1:k
        sum1 = sum((U(i,k)).^2);
        T(i,j) = U(i,j)/((sum1).^(1/2));
    end
end
idx1 = kmeans(T,k);
end