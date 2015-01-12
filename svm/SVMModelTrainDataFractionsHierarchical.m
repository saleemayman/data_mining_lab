function [] = SVMModelTrainDataFractionsHierarchical(fractionStart, fractionEnd, increment, target_attribute, randSeedIn)


%[modelSVMBigSmall_1, modelSVMBigSmall_2, modelSVMBig_1, modelSVMBig_2, modelSVMSmall_2, accuracyAll] = SVMModelHierarchical(target_attribute, dataFraction4AllTests, randSeedIn)
fractions = [fractionStart:increment:fractionEnd];

n = numel(fractions);
fractionTest = ones(1, n) - fractions;

for i = 1:n
    [~, ~, ~, ~, ~, accuracy(i, :)] = SVMModelHierarchical(target_attribute, fractionTest(i), randSeedIn);
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
legend('SVM L1', 'SVM L2', 'SVM g {g, d}', 'SVM l {l, p}', 'SVM m {m, u, w}', 'SVM u {m, u, w}', 'SVM w {m, u, w}')