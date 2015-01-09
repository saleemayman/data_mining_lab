function [svmPerformance, modelSVM, modelSVM_CV, accuracy, testingData...
            targetClassLabels, AttributeLabels] = SVMModelBuildTest(target_attribute,...
                                                                    remove,...
                                                                    ignored_attributes,...
                                                                    fractionTrain,...
                                                                    XValidate,...
                                                                    oneModel,...
                                                                    randData,...
                                                                    Labels,...
                                                                    Attributes,...
                                                                    AttributesTypes)
%  will create SVM models for the number of classes in target_attribute
%  using fractionTrain percent of the actual data.

% generate the data and shuffle the sample order
% run betterDataExtractor.m
AttributeLabels = AttributesTypes;

reducedData = randData;

% extract reduced data
if (remove == 'y')
    numAttr2Delete = numel(ignored_attributes);
    
    for i = 1:numAttr2Delete
        reducedData(:, ignored_attributes(i)) = [];
        disp(['data size: ' num2str(size(reducedData)) ' Ignored attr.: ' AttributesTypes{ignored_attributes(i)}]);
        
        % remove attribute from labels etc
        Labels{ignored_attributes(i)} = [];
        Labels(ignored_attributes(i)) = [];
        Attributes{ignored_attributes(i)} = [];
        Attributes(ignored_attributes(i)) = [];
        AttributesTypes{ignored_attributes(i)} = [];
        AttributesTypes(ignored_attributes(i)) = [];
        
        %disp(['Attr.Types: ' num2str(size(AttributesTypes)) ' Attr.: ' num2str(size(Attributes)) ' Labels: ' num2str(size(Labels))])
    end
end

% disp(['data size: ' num2str(size(reducedData))]);

% train an SVM model 
numData = numel(randData(:, 1));
trainPercent = floor(numData * fractionTrain);
trainingData = reducedData(1: trainPercent, :);
[inputBools, targetBools, targetClasses] = SVMInputAndTargetData(target_attribute, trainingData, Attributes, AttributesTypes);
[modelSVM] = svm_model(inputBools, targetBools, 'linear', 1, targetClasses, oneModel);

targetClassLabels = Labels(ismember(AttributesTypes, target_attribute, 'legacy'));

% only test the first SVM model
if (oneModel == 'n')
	numModels = numel(fieldnames(modelSVM));
else
    numModels = 1;
end

testingData = reducedData(trainPercent + 1:end, :);
[inputsTest, targetsTest] = SVMInputAndTargetData(target_attribute, testingData, Attributes, AttributesTypes);

accuracy = zeros(1, numModels);
for j = 1:numModels
    modelName = ['Class_' targetClasses{j}];
    
    % test the respective SVM model
    [svmPerformance.(modelName), ~, accuracy(j)] = SVMTest(modelSVM.(modelName), inputsTest, targetsTest(:, j), targetClasses{j}, 1);

    if (XValidate == 'y')
       [modelSVM_CV, avgAccuracy] = svmXValidate(modelSVM, modelName, inputsTest, targetsTest(:, j), targetClasses{j}, 1);
    else
        modelSVM_CV = [];
    end
end


