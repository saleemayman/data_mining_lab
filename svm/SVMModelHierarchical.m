function [modelSVMBigSmall_1, modelSVMBigSmall_2, modelSVMBig_1, modelSVMBig_2, modelSVMSmall_2, accuracyAll] = SVMModelHierarchical(target_attribute, dataFraction4AllTests, randSeedIn)
% accuracyAll reutrns the accuracy of each respective model based on the
% initial retained validation data.
% accuracyAll is of size [7, 1] the accuracy of each model is stored in the
% following order: [SVM_level_1, SVM_level_2, SVM_big_1, SVM_big_2, SVM_small_1.1, SVM_small_1.2, SVM_small_1.3]
% SVM_level_1 = SVM model for first hierarchy
% SVM_level_2 = SVM model for second hierarchy
% SVM_big_1 = SVM model for the actual habitat attributes which were
% grouped in the "BIG" dataset on the first Hierarchy. 'x' corresponds to
% the number of habitats grouped in BIG
% SVM_big_2 = same as SVM_big_1.x but for the second Hierarchy
% SVM_small_1.x = same logic as the above two but for the remaining habitat
% values which do not fall in either of the two big sets. 'x' corresponds to
% the number of habitats grouped in this set.

% extract data and the labels once
run betterDataExtractor.m
remove = 'n';
XVal = 'n';
oneMod = 'y';
isDisp = 'n';

ttlInstances = numel(Data(:,1));

% randomly sort the samples for uniformity
[randData, idx_rand, randSeed] = matrixRandomize(Data, randSeedIn);

% retain 20% of the original data for final testing of all models
% dataFraction4AllTests = 0.20;
trainPercent = floor(ttlInstances * (1 - dataFraction4AllTests));
trainData = randData(1: trainPercent, :);
testData = randData(trainPercent + 1:end, :);

% prepare new data for habitat class - First Level
trainRatio = 1.0;%0.85;
bigGroup_1 = {'g' 'd'};
disp(['SVM Level=1'])
[dataBigSmall_1, bigData_1, smallData_1, modelSVMBigSmall_1, accuracy_L1,...
    sAttributes_1, bAttributes_1, newAttributesTypes_1, newAttributes_1] = ...
    SVMModelBigSmall(trainData, Attributes, AttributesTypes, target_attribute, trainRatio, randSeedIn, bigGroup_1, remove, XVal, oneMod, Labels);

% prepare new data for habitat class - Second Level
% trainRatio = 0.80;
bigGroup_2 = {'l' 'p'};
disp(['SVM Level=2'])
[dataBigSmall_2, bigData_2, smallData_2, modelSVMBigSmall_2, accuracy_L2, ...
    sAttributes_2, bAttributes_2, ~, ~] = ...
    SVMModelBigSmall(smallData_1, sAttributes_1, AttributesTypes, target_attribute, trainRatio, randSeedIn, bigGroup_2, remove, XVal, oneMod, Labels);


% create the remaining habitat SVM models
[bigDataRand_1, ~, ~] = matrixRandomize(bigData_1, randSeedIn);
[bigDataRand_2, ~, ~] = matrixRandomize(bigData_2, randSeedIn);
[smallDataRand_2, ~, ~] = matrixRandomize(smallData_2, randSeedIn);

attrIdx = find(ismember(AttributesTypes, target_attribute, 'legacy'));
subAttr = Attributes{attrIdx, 1};
smallSubAttr1 = subAttr( ~ismember(subAttr, bigGroup_1) );
smallSubAttr2 = smallSubAttr1( ~ismember(smallSubAttr1, bigGroup_2) );

disp(['Habitats: ' char(bigGroup_1)'])
[~, modelSVMBig_1, ~, ~, ~, ~, ~] = SVMModelBuildTest(target_attribute,...
    remove, [], trainRatio, XVal, oneMod, bigDataRand_1, Labels, bAttributes_1, AttributesTypes);

disp(['Habitats: ' char(bigGroup_2)'])
[~, modelSVMBig_2, ~, ~, ~, ~, ~] = SVMModelBuildTest(target_attribute,...
    remove, [], trainRatio, XVal, oneMod, bigDataRand_2, Labels, bAttributes_2, AttributesTypes);

disp(['Habitats: ' char(smallSubAttr2)'])
[~, modelSVMSmall_2, ~, ~, ~, ~, ~] = SVMModelBuildTest(target_attribute,...
    remove, [], trainRatio, XVal, 'n', smallDataRand_2, Labels, sAttributes_2, AttributesTypes);

disp(['* * * * * Test/Validation Results of all models on' num2str(dataFraction4AllTests*100) '% of the original data (retained in the beginning). * * * * *'])
[accuracyAll] = SVMTestHierarchical(testData, modelSVMBigSmall_1, modelSVMBigSmall_2, modelSVMBig_1, modelSVMBig_2, modelSVMSmall_2,...
    bigGroup_1, bigGroup_2, smallSubAttr1, smallSubAttr2, Attributes, newAttributes_1, bAttributes_1, bAttributes_2, sAttributes_2, newAttributesTypes_1, AttributesTypes, attrIdx, 'y');


end


function [accuracyAll] = SVMTestHierarchical(testData, modelSVMBigSmall_1, modelSVMBigSmall_2, modelSVMBig_1, modelSVMBig_2, modelSVMSmall_2,...
    bigGroup_1, bigGroup_2, smallSubAttr1, smallSubAttr2, Attributes, newAttributes_1, bAttributes_1, bAttributes_2, sAttributes_2, newAttributesTypes_1, AttributesTypes, attrIdx, isDisp)

accuracyAll = zeros(7, 1);

% retrieve indices of all habitats in the test data
[indices] = findIndexOfHabitats(testData(:, attrIdx), Attributes{attrIdx, 1});

% convert habitat into small/big class for level 1
testDataBigSmall_1 = [];
[testDataBigSmall_1] = replaceAttrVal(testData, attrIdx, bigGroup_1, 'b');
[testDataBigSmall_1] = replaceAttrVal(testDataBigSmall_1, attrIdx, smallSubAttr1, 's');

% validate model and extract indices of class SMALL for level 2
disp(['Level 1 SVM Model. positive_Class-> b={' char(bigGroup_1)' '}  negative_Class-> s={rest of the habitats}'])
[accuracyAll(1), index_pos_1, index_neg_1] = postProcHierarchy(modelSVMBigSmall_1, testDataBigSmall_1, newAttributes_1, newAttributesTypes_1);

testData_neg_1 = testData(index_neg_1, :);  % to test SVM model level 2
testData_pos_1 = testData(index_pos_1, :);  % to test SVM model BIG in level 1

% convert habitat into small/big class for level 2 using reduced data set
testDataBigSmall_2 = [];
[testDataBigSmall_2] = replaceAttrVal(testData_neg_1, attrIdx, bigGroup_1, 'b');
[testDataBigSmall_2] = replaceAttrVal(testDataBigSmall_2, attrIdx, bigGroup_2, 'b');
[testDataBigSmall_2] = replaceAttrVal(testDataBigSmall_2, attrIdx, smallSubAttr2, 's');

% validate level 2 SVM model
disp(['Level 2 SVM Model. positive_Class-> b={' char(bigGroup_2)' '} negative_Class-> s={rest of the habitats}'])
[accuracyAll(2), index_pos_2, index_neg_2] = postProcHierarchy(modelSVMBigSmall_2, testDataBigSmall_2, newAttributes_1, newAttributesTypes_1);

testData_neg_2 = testData_neg_1(index_neg_2, :);    % to test remaining habitat models
testData_pos_2 = testData_neg_1(index_pos_2, :);    % to test SVM model BIG in level 2

% extract test Data corresponding to each model
[inputsTest_b1, targetsTest_b1, targetClasses_b1] = SVMInputAndTargetData('habitat', testData_pos_1, bAttributes_1, AttributesTypes);
[inputsTest_b2, targetsTest_b2, targetClasses_b2] = SVMInputAndTargetData('habitat', testData_pos_2, bAttributes_2, AttributesTypes);
[inputsTest_s2, targetsTest_s2, targetClasses_s2] = SVMInputAndTargetData('habitat', testData_neg_2, sAttributes_2, AttributesTypes);


% test the bigGroup_1 SVM models
disp(['SVM Model Big Set 1. Targets: ' char(bigGroup_1)'])
[~, ~, accuracyAll(3)] = SVMTest(modelSVMBig_1.(['Class_' targetClasses_b1{1}]), inputsTest_b1, targetsTest_b1(:, 1), targetClasses_b1{1}, isDisp);

% test the bigGroup_2 SVM models
disp(['SVM Model Big Set 2. Targets: ' char(bigGroup_2)'])
[~, ~, accuracyAll(4)] = SVMTest(modelSVMBig_2.(['Class_' targetClasses_b2{1}]), inputsTest_b2, targetsTest_b2(:, 1), targetClasses_b2{1}, isDisp);

% test the last remaining SVM models - excluding bigGroup 1 and 2
disp(['SVM Model Small Set. Targets ' char(smallSubAttr2)'])
for j = 1:numel(targetClasses_s2)
    modelName = ['Class_' targetClasses_s2{j}];
    
    % test the respective SVM model
    [~, ~, accuracyAll(4 + j)] = SVMTest(modelSVMSmall_2.(modelName), inputsTest_s2, targetsTest_s2(:, j), targetClasses_s2{j}, isDisp);
end

end


function [accuracy, index_pos, index_neg] = postProcHierarchy(modelSVMBigSmall_1, testDataBigSmall_1, newAttributes_1, newAttributesTypes_1)

% convert into binary data format
[inputsTest_1, targetsTest_1, targetClasses_1] = SVMInputAndTargetData('belongs_to', testDataBigSmall_1, newAttributes_1, newAttributesTypes_1);

% validate model: SVM level 1
fits_1 = predict(modelSVMBigSmall_1.(['Class_' targetClasses_1{1}]), inputsTest_1);

% determine confusion matrix
[confMat_1] = confusionMatrix(fits_1, targetsTest_1(:, 1));

% extract correctly classified NEGATIVE samples from testData for further testing down the model hierarchy
[index_pos, index_neg] = extractIndices(fits_1, targetsTest_1(:, 1));
% testData_2 = testData(index_2, :);

accuracy = 100 * (confMat_1(1,1) + confMat_1(2,2))/sum(sum(confMat_1));
TN_rate = confMat_1(1,1)/sum(confMat_1(1, :));
TP_rate = confMat_1(2,2)/sum(confMat_1(2, :));


disp(['Class: ' targetClasses_1{1} ' Instances: ' num2str(numel(fits_1))...
    ' Acc.: ' num2str(accuracy) '% TN: ' num2str(TN_rate) ' TP: ' num2str(TP_rate) ' Confusion Matrix: '])
disp(confMat_1)
end



function [index_pos, index_neg] = extractIndices(fits, targets)
% extract correctly classified samples from testData for further testing down the model hierarchy
neg = 0;
pos = 0;
index_neg = [];
index_pos = [];
for i=1:numel(fits)
    if ( (fits(i) == 0) && (targets(i) == 0) )
        neg = neg + 1;
        index_neg(neg) = i;
    elseif ( (fits(i) == 1) && (targets(i) == 1) )
        pos = pos + 1;
        index_pos(pos) = i;
    end
end

end


function [confMatrix] = confusionMatrix(fits, targets)
TP = 0;
TN = 0;
FP = 0;
FN = 0;

n = numel(fits);
for i=1:n
    if ( (fits(i) == 1) && (targets(i) == 1) )
        TP = TP + 1;
    elseif ( (fits(i) == 0) && (targets(i) == 0) )
        TN = TN + 1;
	elseif ( (fits(i) == 1) && (targets(i) == 0) )
        FP = FP + 1;
    elseif ( (fits(i) == 0) && (targets(i) == 1) )
        FN = FN + 1;
    end
end

confMatrix = [TN, FP; FN, TP];

end

function [indices] = findIndexOfHabitats(habitatData, habitats)

n = numel(habitats);

for i= 1:n
    idx_name = habitats{i};
    indices.(idx_name) = ismember(habitatData, habitats{i});
end


end








