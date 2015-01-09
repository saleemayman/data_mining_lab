function [inputBoolInstances, targetBoolInstances, targetClasses] = SVMInputAndTargetData(target_attribute, dataNominal, Attributes, AttributesTypes)
% same script as made by Adrien named scriptNominalToBin.m. Divides the
% attributes into 2 sets: input and target arrays for SVM. The target
% attribute is removed from the complete data set and the rest of the
% attributes converted into binary form for SVM training.
% the idea is to convert each instance in a binary word of the form
% (att1hasvalue1 att1hasvalue2 ... att1hasvaluen att2hasvalue1 ... att2hasvalue2 ... att2hasvaluen)
% if (nargin < 2)
%     run betterDataExtractor.m
% 
%     % randomly sort the samples 
%     [dataRand, idx_rand] = matrixRandomize(Data);
% else
%     idx_rand = NaN;
% end

% remove the target attribute from the other attributes
attrIdx = ~ismember(AttributesTypes, target_attribute, 'legacy');
inputAttributes = Attributes(attrIdx);
targetAttribute = Attributes(~attrIdx);
inputData = dataNominal(:, attrIdx);
targetData = dataNominal(:, ~attrIdx);

targetAttrIdx = ismember(AttributesTypes, target_attribute, 'legacy');
targetClasses = Attributes{targetAttrIdx, 1};

[numAttr, ~, ~] = size(AttributesTypes(attrIdx));
attribLength = zeros(numAttr, 1);
for i = 1:numAttr
   attribLength(i) = size(inputAttributes{i}, 2);
end
totBools = sum(attribLength);
% fprintf('The total number of bools will be %i \n', sum(attribLength));

attribArray = zeros(1, totBools);%array of the ascii codes of all attributes in a 1x128 array
index = 0;
for i = 1:numAttr
   for j = 1:size(inputAttributes{i}, 2);
       index = index + 1;
       attribArray(index) = inputAttributes{i}{j};
   end
end

for i = 1:numAttr
   attribLength(i) = size(inputAttributes{i}, 2);
end

%here we go
inputBoolInstances = zeros(size(inputData, 1), totBools);%init of what we want
%now the slow part. Still try to to this column by column

attribCumLength = cumsum(attribLength);
index = 1;
for i = 1:totBools
    if i>attribCumLength(index)
        index = index + 1;
    end
    inputBoolInstances(:,i) = ( ones(size(inputData, 1), 1)*(attribArray(i)) ) == inputData(:, index);
end

% for the target attribute. Must be only 2 classes in target
numTargetSubAttr = numel(targetAttribute{1});
targetArray = zeros(1, numTargetSubAttr);    %array of the ascii codes of target attributes, 

for i = 1:numTargetSubAttr
    targetArray(1, i) = targetAttribute{1}{i};
end

% convert target attribute pair to boolean for targetData
targetBoolInstances = zeros(size(targetData, 1), numTargetSubAttr);
for i = 1:numTargetSubAttr
    targetBoolInstances(:, i) = ( ones(size(targetData, 1), 1)*(targetArray(1, i)) ) == targetData(:, 1);
end


