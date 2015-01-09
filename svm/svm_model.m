function [model] = svm_model(inputData, targetData, kernel, fractionTrain, targetClassLabels, oneModel)

[n, numSubAttr] = size(targetData);

% only train the first SVM model
if (oneModel == 'y')
    numSubAttr = 1;
end


for j = 1:numSubAttr
    modelName = ['Class_' targetClassLabels{j}];
    
    trainPercent = floor(n * fractionTrain);
    trainInputData = inputData(1:trainPercent, :);
    trainTargetData = targetData(1: trainPercent, j);
    %disp(['input: [' num2str(size(trainInputData)) '] output: [' num2str(size(trainTargetData)) ']'])
    
    % train svm
    %model.(modelName) = svmtrain(trainInputData, trainTargetData, 'Kernel_Function', kernel);
    model.(modelName) = fitcsvm(trainInputData, trainTargetData, 'KernelFunction', kernel);
    
    if (fractionTrain < 1)
        testInputData = inputData(trainPercent + 1:end, :);
        testTargetData = targetData(trainPercent + 1:end, j);
        %target_fits = svmclassify(model.(modelName), testInputData);
        target_fits = predict(model.(modelName), testInputData);
        
        count = 0;
        for i=1:numel(target_fits)
            if (target_fits(i) == testTargetData(i, 1))
                count = count + 1;
            end
        end
        
        accuracy = 100 * (count/numel(target_fits));
        
        disp(['sub. attr. id: ' targetClassLabels{j} ' Model Acc.: ' num2str(accuracy) '%'])
    end
    
    clear trainTargetData testTargetData target_fits
end