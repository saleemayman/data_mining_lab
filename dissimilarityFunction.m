function [dissimilarity] = dissimilarityFunction(subAttrCondProb_1, subAttrCondProb_2)
% Lin's Shannon Entropy divergence method for the dissimilarity function
% check paper "An association-based dissimilarity measure for categorical
% data", Le and Ho, 2005 for details.
% dissimilarity function is from "Divergence measures based on the Shannon 
% Entropy", Lin 1991.
%
%   Both inputs are arrays of equal length. Each corresponds to a row of
%   the contingency matrix for a given pair of attributes.
%   Output is the dissimilarity between the two input attributes for a
%   given secondary attribute - the secondary attribute is corresponds to
%   the cols field of the struct array.


numSecdrySubAttr = numel(subAttrCondProb_1);

dissimilarity = 0;
for i = 1:numSecdrySubAttr
    
    [lin] = dissimilarityShannon(subAttrCondProb_1(i), subAttrCondProb_2(i));
    dissimilarity = dissimilarity + lin;
    
end

end

function [lin] = dissimilarityShannon(p1, p2)
% "Divergence measures based on the Shannon  Entropy", Lin 1991.

denom = p1 + p2;
ratio1 = p1 / denom;
ratio2 = p2 / denom;

if (p1 == 0)
    attrLog_1 = 0;
else
    attrLog_1 = log2(2 * ratio1);

end

if (p2 == 0)
    attrLog_2 = 0;
else
    attrLog_2 = log2(2 * ratio2);
end

lin = p1* attrLog_1 + p2 * attrLog_2;
%disp(['log1: ' num2str(attrLog_1) ' log2: ' num2str(attrLog_2) ' p1: ' num2str(p1) ' p2: ' num2str(p2) ' lin: ' num2str(lin)])

end



