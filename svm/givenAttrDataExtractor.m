function [outputData] = givenAttrDataExtractor(inputData, attributeIn, attrIdx)
% extracts data belonging to the attribute values in attributeIn for attribute attrIdx

counts = numel(attributeIn);

outputData = [];
for i = 1:counts
    subAttrVal = attributeIn{1, i};
    subAttrVal_uint8 = cast(subAttrVal, 'uint8');
    positiveInstances = ismember(inputData(:, attrIdx), subAttrVal_uint8);
    outputData = [outputData; inputData(positiveInstances, :)];
end

end