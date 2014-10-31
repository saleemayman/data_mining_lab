function [similarityM] = simiMatrixGenerator( data,simiMeasure )
%simiMatrixGenerator Use the similarity measure on the data to produce a
%similarity matrix. Yay.

%Input:  DATA:  numInstancesx1 cell arrays containing 1xnumAttributes cells.
%        SIMIMEASURE: function handle of the similarity measure to use.  
%Output: SIMILARITYM: numInstancesxnumInstance Matrix containing the scores
numInstances =numel(data);
similarityM= zeros(numInstances);

for i=1:numInstances
    for j=1:numInstances
        similarityM(i,j)=simiMeasure(data{i},data{j});
    end
end

end

