function [contingencyTable] = subAttrCounter(attributes, dataMatrix, mainAttr, secdryAttr)
hit = false;    % bool variable for sub-attribute match

% for i_attr = 1:numAttr
numMainSubAttr = numel(attributes{1,1}{mainAttr});
numSecdrySubAttr = numel(attributes{1,1}{secdryAttr});
contingencyTable = zeros(numMainSubAttr, numSecdrySubAttr);

for i_mainAttr = 1:numMainSubAttr
    mainSubAttrVal = attributes{1, 1}{mainAttr}(i_mainAttr);
    positiveInstances = ismember(dataMatrix(:,mainAttr), mainSubAttrVal);
    subDataMatrix = dataMatrix(positiveInstances, :);
    [samples, ~]= size(subDataMatrix);
    
    for i_secdryAttr = 1:numSecdrySubAttr
        secdrySubAttrVal = attributes{1, 1}{secdryAttr}(i_secdryAttr);
        
        count = 0;     % counter for number of +ve matches
        for n = 1:samples
            hit = strcmp(subDataMatrix(n, secdryAttr), secdrySubAttrVal);
            count = count + hit;
        end
        
        contingencyTable(i_mainAttr, i_secdryAttr) = count;
    end
end

end