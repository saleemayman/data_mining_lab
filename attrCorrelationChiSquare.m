close all;
[attrConditionalProb] = attributeIntersectionCount();
% Generating the Structural Matrix

% generate 23 x 23 matrix with chi-square values for each of our attribute
% combination. Generate than a 23 x 23 matrix with cramer V values for all
% chi-square values



for i = 1:numel(fieldnames(attrConditionalProb))
    mainAttr = ['a' num2str(i)];
    for j = 1:numel(fieldnames(attrConditionalProb))
        %adress Matrix
        otherAttr = ['a' num2str(j)];
        attrPair = [mainAttr '_' otherAttr];
        table = attrConditionalProb.(mainAttr).(attrPair).mat;
        sumTable=sum(sum(table));
        %preperation for chi-square calculation
        rowTotal = sum(table,2);
        columnTotal = sum(table,1);
        %calculate chiValues
        chi = 0;
        for k = 1:numel(rowTotal)
            for l = 1:numel(columnTotal)
                f_e(k,l)=(rowTotal(k)*columnTotal(l))/sumTable;
                chi = chi + ((table(k,l)-f_e(k,l))^2)/f_e(k,l);
            end
        end
        %calculate chiSquareMatrix
        chiSquare(i,j) = chi;
        %calculate Cramer V
        %calculate k value: Minimum between numberOfRows and
        %numberOfColumns
        
        cramerV(i,j) = sqrt(chi/(sumTable*(min([size(table, 1),size(table,2)])-1)));
    end
end
% visualize the cramerV matrix
figure
imagesc(cramerV);
title('cramer V correlation')
axis equal
axis([1 23 1 23])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])

% visualize the chiSquare matrix
figure
imagesc(chiSquare);
title('chi-square correlation')
axis equal
axis([1 23 1 23])
set(gca,'xtick',[])
set(gca,'xticklabel',[])
set(gca,'ytick',[])
set(gca,'yticklabel',[])