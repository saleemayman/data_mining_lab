function [inputData] = replaceAttrVal(inputData, attrIdx, attrToReplace, attrToReplaceWith)
% replaces all samples belonging to attrToReplace with a single value attrToReplaceWith

newSubAttrVal_uint8 = cast(attrToReplaceWith, 'uint8');

n = numel(attrToReplace);
for i = 1:n
    subAttrVal = attrToReplace{1, i};
    subAttrVal_uint8 = cast(subAttrVal, 'uint8');
    positiveInstances = ismember(inputData(:, attrIdx), subAttrVal_uint8);
    inputData(positiveInstances, attrIdx) = newSubAttrVal_uint8;
end

end
