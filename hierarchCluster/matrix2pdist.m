function [pdistMat] = matrix2pdist(matrix)

[rows, cols] = size(matrix);
numElems = rows * (rows - 1)/2;
pdistMat = zeros(1, numElems);

idx = 0;
for i = 1:cols
    rowStart = i + 1;
    
    for j = rowStart:rows
        idx = idx + 1;
         pdistMat(idx) = matrix(j, i);
    end
end












end