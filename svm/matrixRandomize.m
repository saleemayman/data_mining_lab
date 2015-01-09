function [dataRand, idx_rand, seed] = matrixRandomize(Data, seed)


if (nargin < 2)
    seed = rng(1); % new random order
else
    rng(seed);  % use old seed to get the same random order as seed
end
    
[rows, cols] = size(Data);

% randomly permute indices from 1 to 8124 
idx_rand = randperm(rows);

dataRand_r = zeros(rows, cols);

% randomly permute the rows
for i = 1:rows
    dataRand_r(i, :) = Data(idx_rand(i), :);
end
dataRand = dataRand_r;

% % dataRand_c = zeros(rows, cols);
% % 
% % % permute columns
% % for i = 1:rows
% %     dataRand_c(:, i) = dataRand_r(:, idx_rand(i));
% % end
% % 
% % dataRand = dataRand_c;