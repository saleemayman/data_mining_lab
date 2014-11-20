%% Clean ALL THE THINGS!
clc
clearvars
close all
disp('Workspace cleared and ready to go.');
%% Generating the Structural Matrix
disp('Loading Matrix from .txt file.');
[attrConditionalProb] = attributeIntersectionCountCleaned();


%% generate a 128 x 128 Matrix to show dependencies between the single
disp('Matrix Loaded, calculating one to one characteristic table.');
% characteristics

%index initialisation
colIndex=1;
rowIndex=1;

%store the actual start column/row to do proper Indexing
curCol=colIndex;
curRow=rowIndex;

attrRelationTable=zeros(130); %initialize matrix to save Runtime

for i = 1:numel(fieldnames(attrConditionalProb))
    mainAttr = ['a' num2str(i)];
    for j = 1:numel(fieldnames(attrConditionalProb))
        %just build the diagonal Matrix
        %if i>=j:
        %address Matrix
        otherAttr = ['a' num2str(j)];
        attrPair = [mainAttr '_' otherAttr];
        curTable = attrConditionalProb.(mainAttr).(attrPair).mat;
        %calculate sum of rows and columns
        rowTotal = sum(curTable,2);
        columnTotal = sum(curTable,1);
        %for each row go through each column, normalize the entries and
        %write the result into the Attribute Relation Table
        for k = 1:numel(rowTotal)
            for l = 1:numel(columnTotal)
                attrRelationTable(rowIndex,colIndex) = curTable(k,l)/rowTotal(k);
                colIndex = colIndex + 1;
                lastCol= colIndex; % save last column for indexing
            end
            colIndex=curCol; %after each row reset Indexing
            rowIndex = rowIndex + 1;
        end
        rowIndex=curRow;  % after each submatrix, reset Row
        colIndex=lastCol; % continue in proper column
        curCol=lastCol;
    end
    % After expanding Matrix to the right, continue to expand to the bottom
    rowIndex = rowIndex + numel(rowTotal);
    curRow = rowIndex;
    colIndex = 1;
    curCol=1;
end
disp('Done.');
