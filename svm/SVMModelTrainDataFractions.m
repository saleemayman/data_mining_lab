function [accuracy] = SVMModelTrainDataFractions(fractionStart, fractionEnd, increment, target_attribute, randSeedIn)

fractions = [fractionStart:increment:fractionEnd];
n = numel(fractions);

for i = 1:n
    [~, ~, ~, ~, accuracy(i, :), targetClassLabels] = SVMModelBuildTest(target_attribute, 'n', 1, fractions(i), randSeedIn, 'n');
end

[r, numModels] = size(accuracy);

figure('Name', 'SVM Accuracy - Training Data Size')
colors = zeros(numModels, 3);
colors(:, 1) = rand(numModels, 1);
colors(:, 2) = 1 - sort(rand(numModels, 1));
colors(:, 3) = sort(rand(numModels, 1), 'descend');

for i = 1:numModels
    hold on;
    plot(fractions, accuracy(:, i), 'color', colors(i, :), 'LineWidth', 2)
end

xlabel('Percent Data for Training')
ylabel('Accuracy of Models')
legend(targetClassLabels{1, 1})