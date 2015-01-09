function [modelSVMBigSmall_1, modelSVMBigSmall_2, modelSVMBig_1, modelSVMBig_2, modelSVMSmall_2] = SVMModelHierarchical(target_attribute, randSeedIn)

% extract data and the labels once
run betterDataExtractor.m
remove = 'n';
XVal = 'n';
oneMod = 'y';

% randomly sort the samples for uniformity
[randData, idx_rand, randSeed] = matrixRandomize(Data, randSeedIn);

% retain 20% of the original data for final testing of all models
trainPercent = floor(8124 * 0.80);
trainData = randData(1: trainPercent, :);
testData = randData(trainPercent + 1:end, :);

% prepare new data for habitat class - First Level
trainRatio = 0.80;%0.80;
bigGroup_1 = {'g' 'd'};
disp(['SVM Level=1'])
[dataBigSmall_1, bigData_1, smallData_1, modelSVMBigSmall_1,...
    sAttributes_1, bAttributes_1, newAttributesTypes_1, newAttributes_1] = ...
    SVMModelBigSmall(trainData, Attributes, AttributesTypes, target_attribute, trainRatio, randSeedIn, bigGroup_1, remove, XVal, oneMod, Labels);

% prepare new data for habitat class - Second Level
% trainRatio = 0.80;
bigGroup_2 = {'l' 'p'};
disp(['SVM Level=2'])
[dataBigSmall_2, bigData_2, smallData_2, modelSVMBigSmall_2, sAttributes_2, bAttributes_2,...
    ~, ~] = SVMModelBigSmall(smallData_1, sAttributes_1, AttributesTypes, target_attribute, trainRatio, randSeedIn, bigGroup_2, remove, XVal, oneMod, Labels);


% create the remaining habitat SVM models
[bigDataRand_1, ~, ~] = matrixRandomize(bigData_1, randSeedIn);
[bigDataRand_2, ~, ~] = matrixRandomize(bigData_2, randSeedIn);
[smallDataRand_2, ~, ~] = matrixRandomize(smallData_2, randSeedIn);

% trainRatio = 0.70;
disp(['Habitats: ' char(bigGroup_1)'])
[~, modelSVMBig_1, ~, ~, ~, ~, ~] = SVMModelBuildTest(target_attribute,...
    remove, [], trainRatio, XVal, oneMod, bigDataRand_1, Labels, bAttributes_1, AttributesTypes);

disp(['Habitats: ' char(bigGroup_2)'])
[~, modelSVMBig_2, ~, ~, ~, ~, ~] = SVMModelBuildTest(target_attribute,...
    remove, [], trainRatio, XVal, oneMod, bigDataRand_2, Labels, bAttributes_2, AttributesTypes);

disp(['Habitats: ' char(bigGroup_1)' ' + ' char(bigGroup_2)'])
[~, modelSVMSmall_2, ~, ~, ~, ~, ~] = SVMModelBuildTest(target_attribute,...
    remove, [], trainRatio, XVal, 'n', smallDataRand_2, Labels, sAttributes_2, AttributesTypes);

% % test all models on 20% of original data
%SVMTest(modelSVM.(modelName), inputsTest, targetsTest(:, j), targetClasses_1{j}, 1);
attrIdx = find(ismember(AttributesTypes, target_attribute, 'legacy'));
subAttr = Attributes{attrIdx, 1};

smallSubAttr1 = subAttr( ~ismember(subAttr, bigGroup_1) );
smallSubAttr2 = subAttr( ~ismember(smallSubAttr1, bigGroup_2) );
testDataBigSmall = [];
[testDataBigSmall] = replaceAttrVal(testData, attrIdx, bigGroup_1, 'b');
[testDataBigSmall] = replaceAttrVal(testDataBigSmall, attrIdx, bigGroup_2, 'b');
[testDataBigSmall] = replaceAttrVal(testDataBigSmall, attrIdx, smallSubAttr2, 's');

[inputsTest, targetsTest, targetClasses_1] = SVMInputAndTargetData('belongs_to', testDataBigSmall, newAttributes_1, newAttributesTypes_1);
SVMTest(modelSVMBigSmall_1.(['Class_' targetClasses_1{1}]), inputsTest, targetsTest(:, 1), targetClasses_1{1}, 1);
SVMTest(modelSVMBigSmall_2.(['Class_' targetClasses_1{1}]), inputsTest, targetsTest(:, 1), targetClasses_1{1}, 1);

[inputsTest_b1, targetsTest_b1, targetClasses_b1] = SVMInputAndTargetData('habitat', testData, bAttributes_1, AttributesTypes);
SVMTest(modelSVMBig_1.(['Class_' targetClasses_b1{1}]), inputsTest_b1, targetsTest_b1(:, 1), targetClasses_b1{1}, 1);

[inputsTest_b2, targetsTest_b2, targetClasses_b2] = SVMInputAndTargetData('habitat', testData, bAttributes_2, AttributesTypes);
SVMTest(modelSVMBig_2.(['Class_' targetClasses_b2{1}]), inputsTest_b2, targetsTest_b2(:, 1), targetClasses_b2{1}, 1);

[inputsTest_s1, targetsTest_s2, targetClasses_s2] = SVMInputAndTargetData('habitat', testData, sAttributes_2, AttributesTypes);

for j = 1:numel(targetClasses_s2)
    modelName = ['Class_' targetClasses_s2{j}];
    
    % test the respective SVM model
    SVMTest(modelSVMSmall_2.(modelName), inputsTest_s1, targetsTest_s2(:, j), targetClasses_s2{j}, 1);
end


% disp(['L1: ' char(targetClasses_1)'])
% disp(['b1: ' char(targetClasses_b1)'])
% disp(['b2: ' char(targetClasses_b2)'])
% disp(['s1: ' char(targetClasses_s2)'])
end

