function [entireDataBigSmall, bigSetDataMatrix, smallSetDataMatrix,...
            AttributesTypes_newAttr, Attributes_newAttr,...
            Attributes_smallNewAttr, Attributes_bigNewAttr] = createBigSmallClasses(inputData,...
                                                                                    Attributes,...
                                                                                    AttributesTypes,...
                                                                                    target_attribute,...
                                                                                    bigGroup)
% Does the following:
% 1. Divides habitat into 2 classes: (b)ig and (s)mall
% 2. Separates the small and big habitat class data
% 3. To all the instances replaces the habitat values by (s) or (b)
% 4. Modifies the Attribute labels for the new attribute 'belongs_to'

attrIdx = find(ismember(AttributesTypes, target_attribute, 'legacy'));
subAttr = Attributes{attrIdx, 1};
numSubAttr = numel(subAttr);

% get the counts for each habitat class
[habitatInstCounts] = subAttrInstanceCounter(Attributes, AttributesTypes, inputData, target_attribute);

% separate the Big and Small sets
% bigCount = 0;
% smallCount = 0;
% for i = 1:numSubAttr
%     if (instDistributions.mat(i) > (separator + eps) )
%         bigCount = bigCount + 1;
%         bigSubAttr{1, bigCount} = subAttr{1, i};
%     else
%         smallCount = smallCount + 1;
%         smallSubAttr{1, smallCount} = subAttr{1, i};
%     end
% end

bigSubAttr = bigGroup;
smallSubAttr = subAttr( ~ismember(subAttr, bigGroup) );

% data for the Big and Small sets. Will be used to train OvA SVMs
[bigSetDataMatrix] = givenAttrDataExtractor(inputData, bigSubAttr, attrIdx);
[smallSetDataMatrix] = givenAttrDataExtractor(inputData, smallSubAttr, attrIdx);

% replace the habitat with new attribute Set = {(b)ig, (s)mall}. 
% [rows, cols] = size(inputData);
entireDataBigSmall = [];

% Habitat does not contain any attributes with labels b or s
[entireDataBigSmall] = replaceAttrVal(inputData, attrIdx, bigSubAttr, 'b');
[entireDataBigSmall] = replaceAttrVal(entireDataBigSmall, attrIdx, smallSubAttr, 's');

% change the attribute labels 
AttributesTypes_newAttr = AttributesTypes;
AttributesTypes_newAttr{attrIdx, :} = 'belongs_to';
Attributes_newAttr = Attributes;
Attributes_newAttr{attrIdx, :} = [];
Attributes_newAttr{attrIdx, :} = {'b' 's'};

Attributes_smallNewAttr = Attributes;
Attributes_smallNewAttr{attrIdx, :} = [];
Attributes_smallNewAttr{attrIdx, :} = smallSubAttr;

Attributes_bigNewAttr = Attributes;
Attributes_bigNewAttr{attrIdx, :} = [];
Attributes_bigNewAttr{attrIdx, :} = bigSubAttr;

disp(['size Data: ' num2str(numel(entireDataBigSmall(:,1)))...
    ', small: ' num2str(numel(smallSetDataMatrix(:,1)))...
    ', size big: ' num2str(numel(bigSetDataMatrix(:,1)))...
    ', small Attr.: ' char(smallSubAttr)' ', big Attr.: ' char(bigSubAttr)'])

end


function [outputData] = givenAttrDataExtractor(inputData, attributeIn, attrIdx)

counts = numel(attributeIn);

outputData = [];
for i = 1:counts
    subAttrVal = attributeIn{1, i};
    subAttrVal_uint8 = cast(subAttrVal, 'uint8');
    positiveInstances = ismember(inputData(:, attrIdx), subAttrVal_uint8);
    outputData = [outputData; inputData(positiveInstances, :)];
end

end



