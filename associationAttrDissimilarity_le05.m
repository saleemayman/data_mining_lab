function [structAttrSim] = associationAttrDissimilarity_le05()
% [Lin] = dissimilarityFunction(subAttrCondProb_1, subAttrCondProb_2)

% load the sub-attributes for each attribute
fid = fopen('attribute_headers.data');
attributes = textscan(fid,'%s');
fclose(fid);
clear fid;

attrConditionalProb = attributeIntersectionCount();

numAttr = numel( fieldnames(attrConditionalProb) );
% id_subAttr = [attributes{1, 1}{i}(j)];
structAttrSim = struct();

for i = 1:numAttr
    attr = ['a' num2str(i)];
    structAttrSim.(attr) = struct();
    numSubAttr = numel(attributes{1,1}{i});
    
    % loop through each sub-attribute and make all possible pairs
    for k = 1:numSubAttr
        subAttr1 = attributes{1, 1}{i}(k);
        
%         if strcmp(subAttr1, '?')
%             subAttr1 = 'Q';
%         end
        
        % sum the dissimilarity for each pair and store it in the struct
        for n = 1:numSubAttr    % or  n = (k + 1):numSubAttr
            subAttr2 = attributes{1, 1}{i}(n);
            
%             if strcmp(subAttr2, '?')
%                 subAttr2 = 'Q';
%             end
            
            attrSimPair = [subAttr1 '_' subAttr2];
            %attrSimPairT = [subAttr2 '_' subAttr1];
            
            structAttrSim.(attr).(attrSimPair) = 0;
            
            %numAttrPairs = numel( fieldnames( attrConditionalProb.(attr) ) );
            total = 0;
            for j = 1:numAttr
                % skip the same index, dissimilarity is zero, i.e., identical
                if (j == i)
                    continue
                end
                
                attrPair = [attr '_' 'a' num2str(j)];
                
                mainAttrVal1 = attrConditionalProb.(attr).(attrPair).mat(k, :);
                mainAttrVal2 = attrConditionalProb.(attr).(attrPair).mat(n, :);

                total_1 = sum(mainAttrVal1);
                total_2 = sum(mainAttrVal2);

                if (total_1 == 0)
                    total_1 = 1;
                end
                if (total_2 == 0)
                    total_2 = 1;
                end

                mainAttrVal1 = mainAttrVal1/total_1;  % get the probability
                mainAttrVal2 = mainAttrVal2/total_2;  % get the probability

                dissimilarity_12 = dissimilarityFunction(mainAttrVal1, mainAttrVal2);

                total = total + dissimilarity_12;
            end
            
            structAttrSim.(attr).(attrSimPair) = total;
            %structAttrSim.(attr).(attrSimPairT) = total;
        end
    end
end
end



