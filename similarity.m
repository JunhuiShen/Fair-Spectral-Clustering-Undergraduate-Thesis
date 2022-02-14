function S = similarity(X,epsilon)
D = pdist(X);
S = squareform(D);
S_row = size(S,1);
S_col = size(S,2);
for i = 1: S_row
    for j = 1:S_col
        if S(i,j) < epsilon && i ~=j
            S(i,j) = 1;
        else
            S(i,j)=0;
        end
    end
end
end