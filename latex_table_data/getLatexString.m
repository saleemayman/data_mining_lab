function [latexStr] = getLatexString(structData, tableHeading)

rows = cellstr(structData.rows);
cols = cellstr(structData.cols');
data = structData.mat;

[numRows, numCols] = size(data);

latexStr{1, 1} = ['\begin{tabular}{' repmat('c', 1, (numCols + 1)) '}'];
latexStr{end + 1, 1} = ['\hline'];
latexStr{end + 1, 1} = ['& \multicolumn{' num2str(numCols) '}{c}{' tableHeading '} \\'];

headers = [];
for j = 1:numCols
   headers = [headers ' & {\bf ' char(cols(j)) '}']; 
end
headers = [headers ' \\'];
latexStr{end + 1, 1} = headers;
latexStr{end + 1, 1} = ['\hline'];

for i = 1:numRows
    tableLine = [];
    tableLine = [tableLine '{\bf ' char(rows(i)) '} & '];
    for j = 1:(numCols - 1)
        tableLine = [tableLine num2str(data(i, j)) ' & '];
    end
    tableLine = [tableLine num2str(data(i, numCols)) ' \\'];
    
    latexStr{end + 1, 1} = tableLine;
end

latexStr{end + 1, 1} = ['\hline'];
latexStr{end + 1, 1} = ['\end{tabular}'];
latexStr{end + 1, 1} = [''];
   

end