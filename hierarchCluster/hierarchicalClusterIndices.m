function [T] = hierarchicalClusterIndices(numClusters, clusterSpacing, isPlot)
% generate numClusters of hierarchical clusters using the "dissimilarity"
% matrix obtained from Lin_1991 method.
% 
% clusterSpacing implies the resolution of number of clusters. If
% clusterSpacing := 1 then clusters := numClusters 
% else, clusters := numClusters/clusterSpacing
% 
% isPlot is either 0 or 1. If 1 then plot dendrogram for each cluster size
% 
% outpout T is a matrix with rows corresponding to the instance number and
% columnm numbers corresponding to the number of clusters for that column.

% load the dissimilarity matrix. DO NOT COMPUTE IT. IT WILL TAKE 48 HOURS!
load dissimilarityMatrix_Lin_1991.mat

% convert the dissimilarity matrix into a vector of upper triangular elems
Y = matrix2pdist(dissimilarity_Lin);

% normalize the "distances" to 1, perfectly similarity -> 0
Y_norm = Y/max(Y);

% generate linkages using hierarchical clustersíng
Z_norm = linkage(Y_norm);

[rows, ~] = size(dissimilarity_Lin);
T = zeros(rows, 1);

count = 0;
for i = numClusters:-clusterSpacing:1
    count = count + 1;
    
    % generate clusters and save instance cluster associations in T
    T(:, count) = cluster(Z_norm,'maxclust', i);
    
    if (isPlot == 1)
        figure('Name', ['Dendrogram for ' num2str(i) ' Clusters']);
        
        if (i ~= 1)
            % color coding for i number of clusters
            color = Z_norm(end - i + 2, 3) - eps;
        else
            color = Z_norm(end, 3) + eps;
        end
        
        % generate dendrogram for the given number of clusters
        dendrogram(Z_norm, 0, 'colorthreshold', color)
        
        % annotate plot
        title(['Hierarchical Clustering with ' num2str(i) ' Clusters'])
        set(gca,'xtick',[])
        set(gca,'xticklabel',[])
        xlabel('Samples {\bf [1 \rightarrow 8124]}')
        ylabel('Distance measure {\bf \it{d} \in [0, 1]}')
    end
end




