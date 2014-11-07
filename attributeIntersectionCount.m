function [attrConditionalProb] = attributeIntersectionCount()
% reads the .data file and creates a structered array and a matrix form of
% the data.

% read entire data the way it is
fid = fopen('agaricus-lepiota.data');
C = textscan(fid,'%s'); % Read data skipping header
fclose(fid);
clear fid;

% remove commas and arrange data in easily indexiable matrix
[samples, ~] = size(C{1, 1});

% copy data from cell structure to the matrix data as string characters
for i_mainAttr = 1:samples
    dataMatrix(i_mainAttr, :) = strrep(C{1,1}{i_mainAttr,1}, ',','');   % removes commas
end

% function [attributeData] = attributeStructCreate(attributes)

% load the sub-attributes for each attribute
fid = fopen('attribute_headers.data');
attributes = textscan(fid,'%s');
fclose(fid);
clear fid;

attrConditionalProb = struct();   % empty structure
numAttr = numel(attributes{1,1});    % this is 23

for i_mainAttr = 1:numAttr
    id_field = ['a' num2str(i_mainAttr)];                 % attribute field name
    attrConditionalProb.(id_field) = struct();         % create attribute field
    
    for i_secdryAttr = (i_mainAttr + 1):numAttr
        subId_field = ['a' num2str(i_mainAttr) '_' 'a' num2str(i_secdryAttr)];
        
        r = numel(attributes{1, 1}{i_mainAttr});     % contingent table rows
        c = numel(attributes{1, 1}{i_secdryAttr});     % contingent table columns
        
        attrConditionalProb.(id_field).(subId_field).rows = [attributes{1, 1}{i_mainAttr}]';   % main attribute's values
        attrConditionalProb.(id_field).(subId_field).cols = [attributes{1, 1}{i_secdryAttr}];   % second attribute's values
        attrConditionalProb.(id_field).(subId_field).mat = zeros(r, c);  % create empty attribute contingent table
        
        % find the number of matching samples for the two attribute combinations
        [contingencyTable] = subAttrCounter(attributes, dataMatrix, i_mainAttr, i_secdryAttr);
        attrConditionalProb.(id_field).(subId_field).mat = contingencyTable;
    end
end



end
