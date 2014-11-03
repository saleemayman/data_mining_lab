function [dataMatrix, structAttributeData] = structAndMatrixDataGenerator(startIndex, endIndex)
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
for i = 1:samples
    dataMatrix(i, :) = strrep(C{1,1}{i,1}, ',','');   % removes commas
end

% function [attributeData] = attributeStructCreate(attributes)

% load the sub-attributes for each attribute
fid = fopen('attribute_headers.data');
attributes = textscan(fid,'%s');
fclose(fid);
clear fid;

structAttributeData = struct();   % empty structure
numAttr = numel(attributes{1,1});    % this is 23

for i = 1:numAttr
    numSubAttr = numel(attributes{1,1}{i});   % number of sub_attributes
    i_attr = ['a' num2str(i)];                 % attribute field name
    structAttributeData.(i_attr) = struct();         % create attribute field
    
    % initialize all sub attributes to zero count
    for j = 1:numSubAttr
        id_subAttr = [attributes{1, 1}{i}(j)]; % sub-attr field name
        
        % ? is an invalid field name, replacing with Q (not used anywhere in the data)
        if strcmp(id_subAttr, '?')
            id_subAttr = 'Q';
        end
        
        structAttributeData.(i_attr).(id_subAttr) = 0;  % create sub-attribute field
    end
end

% if no sample range given, generate array for entire data set
if nargin < 2
    [rows, cols] = size(dataMatrix);
    startIndex = 1;
    endIndex = rows;
end

hit = false;    % bool variable for sub-attribute match
for i_attr = 1:numAttr
    numSubAttr = numel(attributes{1,1}{i_attr});
    
    for i_subAttr = 1:numSubAttr
        count = 0;     % counter for number of +ve matches
        
        %disp(['i_attr: ' num2str(i_attr) ' i_subAttr: ' num2str(i_subAttr)])
        for n = startIndex:endIndex
            hit = strcmp(dataMatrix(n, i_attr), attributes{1, 1}{i_attr}(i_subAttr));
            count = count + hit;
        end
        
        attr_id = ['a' num2str(i_attr)];
        id_subAttr = [attributes{1, 1}{i_attr}(i_subAttr)]; % sub-attr field name
        
        % ? is an invalid field name, replacicleang with Q (not used anywhere in the data)
        if strcmp(id_subAttr, '?')
            id_subAttr = 'Q';
        end
        %disp([attr_id ' ' id_subAttr ' ' num2str(count)])
        structAttributeData.(attr_id).(id_subAttr) = count;
        
    end
end


