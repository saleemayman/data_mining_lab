function [ score ] = strCmpRefined(instance1,instance2)
%strCmpRefined Is basically string compare, but without matching 
%missing data label between them. That is, if two instances are missing
%data, their similarity score shall not be augmented.

%Input:  INSTANCE1,INSTANCE2: the things which are to be compared, that is,
%        1xnumAttributes cells. Must be of same dimensions, duh. 
%
%Output: SIMILARITYM: a numerical score expressing the similarity between
%        the two instances. The higher, the better.
numAttributes1=numel(instance1);
numAttributes2=numel(instance2);
if numAttributes1~=numAttributes2
    disp('Your two instances have different dimensions, you moron!')
    disp('[In strCmpRefined.m]')
end
score=0;
for i=1:numAttributes1
    if i==11%the one with missing values
        if isequal(instance1{i},'Q')||isequal(instance2{i},'Q')
            %no modification
        else
            score=score+strcmp(instance1{i},instance2{i});%normal modification
        end
    else
        score=score+strcmp(instance1{i},instance2{i});
    end
end
%normalization of the score by the number of attributes
score=score/(1.0*numAttributes1);
end

