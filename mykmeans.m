function [idx,C] = mykmeans(X,k,n)
%k-means clustering
init_centroid = pick_initial_centroids(X,k);
index = find_centroids(X,init_centroid,k);
centroids = compute_centroids(X,index,k);
[idx,C]=repeat_step(X,centroids,n,k);

%step 1: we randomly pick the representatives from the original vectors
function init_centroid = pick_initial_centroids(X,k)
random_number = randperm(size(X,1));
init_centroid = X(random_number(1:k),:);
end

%step 2: compute j where j is the group label to which x_i is assigned
%j = 1,...,k
function index = find_centroids(X,init_centroid,k)
index = [];
for i = 1:length(X)
    for j = 1:k
        dist(j) = norm(X(i,:)-init_centroid(j,:),2);
    end
    newindex = find(dist == min(dist));
    index = [index,newindex];
end
index = index';
end

%step 3:compute the group representative z_j for each group j = 1,...,k
%z_j is the mean of the vectors x_i in its group
function centroids = compute_centroids(X,index,k)
for i = 1:k
    newindex = find(index == i);
    num = length(newindex);
    centroids(i,:) = sum(X(newindex, :)) / num;
end
end

%step 4: repeat step 1 and step 2 until J^{clust} gets stable
function [newidx,newcentroids1]=repeat_step(X,centroids,n,k)
centroids1 =  centroids;
for i = 1: length(n)
    newidx = find_centroids(X,centroids1,k);
    centroids1 = compute_centroids(X,newidx,k);
    newcentroids1 = centroids1;
end
end
end