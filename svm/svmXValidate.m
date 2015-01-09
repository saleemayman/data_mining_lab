function [modelSVM_CV, accuracy] = svmXValidate(modelSVM, modelName, inputsTest, targetsTest, targetClass, isDisp)


% cross-validate on training data
modelSVM_CV.(modelName) = crossval(modelSVM.(modelName), 'KFold', 10);

confMatrix = zeros(2, 2);
for i = 1:10
    [~, confMatrixOut] = SVMTest(modelSVM_CV.(modelName).Trained{i}, inputsTest, targetsTest, targetClass, 0);
    confMatrix = confMatrix + confMatrixOut;
end
confMatrix = floor(confMatrix./10); % take average

accuracy = 100 * (confMatrix(4) + confMatrix(1))/sum(sum(confMatrix));

if (isDisp == 1)
    disp(['Class: ' targetClass ' Instances: ' num2str(numel(targetsTest)) ' Acc.: ' num2str(accuracy) '% Avg. Confusion Matrix: '])
    disp(confMatrix)
end