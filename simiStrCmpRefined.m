function [ SimiMat ] = simiStrCmpRefined( Data )
%Computes the similarity Matrix for Data, a n_instancexn_attribute array
SimiMat=zeros(size(Data,1));
tic
for i=1:size(Data,1)
    inst=Data(i,:);
    padder=ones(size(Data));
    padInst=bsxfun(@times,inst,padder);
    score=sum(padInst==Data,2);
    SimiMat(i,:)=score;
end

%Correct the missing value issue. cast('Q','uint8')
index=find(Data(:,12) == cast('Q','uint8'));
tmp=zeros(size(Data,1));
tmp(index)=1;
modif=-tmp*tmp';
SimiMat=SimiMat+modif;
end

