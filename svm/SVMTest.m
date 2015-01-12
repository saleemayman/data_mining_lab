function [svmPerf, confMatrix, accuracy] = SVMTest(model, inputData, targetData, targetClassLabel, isDisp)

%modelName = ['Class_' targetClassLabels{j}];
%target_fits = svmclassify(model, inputData);
target_fits = predict(model, inputData);
% save target_fits target_fits
% classification cases
TP = 0;
TN = 0;
FP = 0;
FN = 0;

n = numel(target_fits);
for i=1:n
    if ( (target_fits(i) == 1) && (targetData(i) == 1) )
        TP = TP + 1;
    elseif ( (target_fits(i) == 0) && (targetData(i) == 0) )
        TN = TN + 1;
	elseif ( (target_fits(i) == 1) && (targetData(i) == 0) )
        FP = FP + 1;
    elseif ( (target_fits(i) == 0) && (targetData(i) == 1) )
        FN = FN + 1;
    end
end

confMatrix = [TN, FP; FN, TP];
accuracy = 100 * (TP + TN)/(TP + TN + FN + FP);

svmPerf.confMat = confMatrix;
svmPerf.TP_rate = TP/(FN+TP);
svmPerf.TN_rate = TN/(TN+FP);
svmPerf.FP_rate = FP/(TN+FP);
svmPerf.FN_rate = FN/(FN+TP);

if (isDisp == 'y')
    disp(['Class: ' targetClassLabel ' Instances: ' num2str(n)...
        ' Acc.: ' num2str(accuracy) '% TN: ' num2str(svmPerf.TN_rate) ' TP: ' num2str(svmPerf.TP_rate) ' Confusion Matrix: '])
    disp(svmPerf.confMat)
end
% disp(['Class: ' targetClassLabel ' Instances: ' num2str(n)...
%             ' TP: ' num2str(TP_rate) ' TN: ' num2str(TN_rate)...
%             ' FP: ' num2str(FP_rate) ' FN: ' num2str(FN_rate) ]);
