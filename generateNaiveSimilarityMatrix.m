function [similarityMatrix] = generateNaiveSimilarityMatrix(data)
% Generate similarity matrix for each attribute for all 8124 samples.

% similarity matrix dimensions
rows = numel(data(:, 1));

similarityMatrix = zeros(numel(data(:, 1)), numel(data(:, 1)));

% k-loop for attribute
for i = 1:rows
    for j = 1:rows
        c = (data(i, :) == data(j, :));
        similarityMatrix(i, j) = sum(c) / numel(c);
    end
end

% visualize the matrix
figure
imagesc(newSimMat);
axis equal
axis([1 8124 1 8124])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])
title('Naive Similarity Matrix')