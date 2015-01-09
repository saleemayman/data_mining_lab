function [attrInstances] = subAttrInstanceCounter(attributes, AttributesTypes, dataMatrix, target_attribute)
hit = false;    % bool variable for sub-attribute match

% for i_attr = 1:numAttr
attrIdx = find(ismember(AttributesTypes, target_attribute, 'legacy'));
numMainSubAttr = numel(attributes{attrIdx, 1});

attrInstances.rows = 'Instances';
attrInstances.cols = '';
for i_mainAttr = 1:numMainSubAttr
    mainSubAttrVal = attributes{attrIdx, 1}{i_mainAttr};
    mainSubAttrVal_uint8 = cast(mainSubAttrVal, 'uint8'); 
    positiveInstances = ismember(dataMatrix(:, attrIdx), mainSubAttrVal_uint8);
    subDataMatrix = dataMatrix(positiveInstances, :);
    
    subAttrName = attributes{attrIdx, 1}{i_mainAttr};
    
    [samples, ~]= size(subDataMatrix);
    
    %attrInstances.(subAttrName) = samples;
    attrInstances.cols = [attrInstances.cols subAttrName];
    attrInstances.mat(1, i_mainAttr) = samples;
end

end