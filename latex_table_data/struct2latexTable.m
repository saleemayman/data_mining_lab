function [] = struct2latexTable()

% structNames = struct();
% [structDepth, structNames] = getStructFieldDepth(structData, structNames, 0);

% get the attribute instance counts for different pairs
[structData] = attributeIntersectionCount();

mainFields = fieldnames(structData);
numMainFields = numel(mainFields);

latexTableStr{1, 1} = [];
latexTableStr(1) = [];
for i = 1:numMainFields
	subFields = fieldnames(structData.(mainFields{i, 1}));
    numSubFields = numel(subFields);
    
    for j = 1:numSubFields
        latexStr{1, 1} = [];
        latexStr(1) = [];
        
        tableHeading = char(subFields{j, 1});
        tableHeading = regexprep(tableHeading, 'a', 'Attr. ');
        tableHeading = regexprep(tableHeading, '_', ' and ');
        latexStr = getLatexString(structData.(mainFields{i, 1}).(subFields{j, 1}), tableHeading);
        
        latexTableStr = [latexTableStr;  latexStr];
    end
end

[numLines , ~] = size(latexTableStr);

fileID = fopen('latexTableSubAttrInstances.tex','w');
for i = 1:numLines
    fprintf(fileID, '%s \n', latexTableStr{i, 1});
end

fclose(fileID);


