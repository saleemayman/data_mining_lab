function [accuracy] = SVMModelReducedAttribtues(target_attribute, randSeedIn)

% extract data and the labels once
run betterDataExtractor.m

oneModel = 'y';
depth = 2;
accuracy = zeros(22, 1, depth);
maxAccIdx = zeros(1, depth);
figure('Name', ['SVM Grass Accuracy After Attribute/s Removal'])

[randData, idx_rand, randSeed] = matrixRandomize(Data, randSeedIn);

for k = 1:depth
    for i = 1:(23 - k)
        [~, ~, maxAttrIdx] = find(maxAccIdx);
        attrRemove = [maxAttrIdx i];
        %[~, ~, ~, ~, accuracy(i, :, k), targetClassLabels, AttributeLabels] = SVMModelBuildTest(target_attribute, 'y', attrRemove, 0.60, randSeedIn, 'n');
        [~, ~, ~, accuracy(i, :, k), ~, targetClassLabels, ~] = SVMModelBuildTest(target_attribute,...
                        'y', attrRemove, 0.60, 'n', oneModel, randData, Labels, Attributes, AttributesTypes);
    end
    
    [maxAccuracy(k), idx] = max(accuracy(:, :, k));
    maxAccIdx(k) = idx;
    
    [r, numModels, ~] = size(accuracy);
    
    colors = zeros(numModels, 3);
    colors(:, 1) = rand(numModels, 1);
    colors(:, 2) = [randperm(numModels)/numModels]';
    colors(:, 3) = sort(rand(numModels, 1), 'descend');
    
    for i = 1:numModels
        hold on;
        subplot(ceil(depth/4), 4, k);
        plot([1:(23 - k)], accuracy(1:(23 - k), i, k), 'color', colors(i, :))

        xlabel('Discarded Attribute')
        ylabel('Accuracy of Models %')
        title(['Attribute/s Discarded: ' num2str(k)])
    end
end
%   set(gca, 'xticklabel', [AttributeLabels{1:22, 1}]);
xlabel('Discarded Attribute')
ylabel('Accuracy of Models %')
legend(targetClassLabels{1, 1})