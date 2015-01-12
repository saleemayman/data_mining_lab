function [ barInput ] = attributes_counter_mat(index,Data,Attributes)
%ATTRIBUTES_COUNTER MAT : NOW FOR MATRICES
%The function takes the index of the desired attribute as input
%and outputs a vector containing the number of instances per attribute
%value, which is fit to be represented for example with the bar function.
% INDEX:      integer between 1 and 23
% DATA:       MATRIX containing all the different instances
% ATTRIBUTES: cell containing all the different possible values of the
%             attribute
% BARINPUT:   array of size(numAttributesValues,1), vector containing the
%             number of instances per attribute value

barInput=zeros(size(Attributes{index},2),1);
for i=1:size(Data,1)
    for j=1:size(Attributes{index},2);
        if Data(i,index)==Attributes{index}{j}
            barInput(j)=barInput(j)+1;
            break;
        end
    end
end


end
