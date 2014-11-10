function [dissimilarityMatrix] = generateSimilarityMatrix_Le05Lin91(data, start_i, end_i)
% Generate similarity matrix for each attribute for all 8124 samples.

% similarity matrix dimensions
[rows, numAttr] = size(data);

dissimilarityMatrix = zeros(numel(data(:, 1)), numel(data(:, 1)));

% get the attribute dis-similarities between sub-attributes using Lin91
[structAttrSim] = associationAttrDissimilarity_le05();

% k-loop for attribute
for i = start_i:end_i%rows
    disp(i)
    for j = 1:rows
        attrDissimScore = 0;
        for k = 1:numAttr
            attr = ['a' num2str(k)];
%             
%             if ( data(i, k) == '?' )
%                 subAttr1 = 'Q';
%             else
%                 subAttr1 = data(i, k);
%             end
%             
%             if ( data(j, k) == '?' )
%                 subAttr2 = 'Q';
%             else
%                 subAttr2 = data(j, k);
%             end
%             
%             attrPair = [subAttr1 '_' subAttr2];

            attrPair = [data(i, k) '_' data(j, k)];
%             if ( data(i, k) == data(j, k) )
%                 attrDissimScore = 0;
%             else
%                 attrDissimScore = structAttrSim.(attr).(attrPair);
%             end

%             attrDissimScore = structAttrSim.(attr).(attrPair);
            attrDissimScore = attrDissimScore + structAttrSim.(attr).(attrPair);
        end
        dissimilarityMatrix(i, j) = attrDissimScore;
    end
end

% visualize the matrix
figure
imagesc(dissimilarityMatrix);
axis equal
axis([1 8124 1 8124])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])