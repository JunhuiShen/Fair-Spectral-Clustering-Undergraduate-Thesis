rng("default")
N = 800;
r1 = 2;r2 = 4;r3 = 6;
theta = linspace(0,2*pi,N)';
X1 = r1*[cos(theta),sin(theta)]+ rand(N,1);
X2 = r2*[cos(theta),sin(theta)]+ rand(N,1);
X3 = r3*[cos(theta),sin(theta)]+ rand(N,1);
X = [X1;X2;X3];
epsilon = 0.6;k = 3; 

S = similarity(X,epsilon);
idx1 = my_unnormalized_sc(S,k)

figure
gscatter(X(:,1),X(:,2),idx1,"rgb");
legend("cluster 1","cluster 2","cluster 3")
title("spectral clustering")