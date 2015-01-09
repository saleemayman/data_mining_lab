function [svmClassification] = SVMClusterClassify(target_attribute, fractionTrain, modelSVM, targetClasses)

% generate the data and shuffle the sample order
run betterDataExtractor.m
[randData, idx_rand, randSeed] = matrixRandomize(Data);


if (nargin < 3)
    % train an SVM model on the data
    [inputBools, targetBools, targetClasses] = SVMInputAndTargetData(target_attribute, randData, Attributes, AttributesTypes);
    [modelSVM] = svm_model(inputBools, targetBools, 'rbf', fractionTrain, targetClasses);
end

% Get the clusters for all the samples for 22 clusters
% load the dissimilarity matrix. DO NOT COMPUTE IT. IT WILL TAKE 48 HOURS!
load dissimilarityMatrix_Lin_1991.mat

% hierarchical clustering
Y = matrix2pdist(dissimilarity_Lin);
Y_norm = Y/max(Y);
Z_norm = linkage(Y_norm);
T = cluster(Z_norm, 'maxclust', 22);

% consolidate the samples for each cluster
[clusterSamples] = extractClusterSamples(T);

data_idx = 1:8124;
clusters = numel(fieldnames(clusterSamples));
for i = 1:clusters
    clusterName = ['cluster_' num2str(i)];

    instances = Data(ismember(data_idx, clusterSamples.(clusterName).Idx), :);
    [inputCluster, targetCluster] = SVMInputAndTargetData(target_attribute, instances, Attributes, AttributesTypes);
    
    numModels = numel(fieldnames(modelSVM));
    disp(['Cluster ID: ' num2str(i)]);
    for j = 1:numModels
        modelName = ['Class_' targetClasses{j}];
        
        % test the respective SVM model with the clusters
        [svmClassification.(clusterName).(modelName)] = SVMTest(modelSVM.(modelName), inputCluster, targetCluster(:, j), targetClasses{j});
    end
end
