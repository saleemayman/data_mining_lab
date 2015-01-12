function [ sGR, sGRLabel,sKData ] = getGroupLimits( indexKmeans,K,Data )
%getGroupLimits get the limits of the group
%INPUT:
%-indexKmeans: the index that comes out from the kmeans clustering function
%-K: the number of clusters
%-Data: array containing the original data
%OUTPUT:
%-sGR: an 2x(numCluster+1) array that contains the starting and ending
%values for each clusters plus the whole dataset
%-sGRLabel: 2x(numCluster+1) cell containing the labels for the 
%aforementioned clusters and whole group
%-sKData: Data sorted by clusters
[KSorted,KSortedIndx]=sort(indexKmeans);
KGroupLimits=zeros(K+1,1);
KGroupLimits(K+1)=size(Data,1)+1;%Otherwise no upper group Limit
for i=1:K
 KGroupLimits(i)= find(KSorted==i,1);
end
sKData=Data(KSortedIndx,:);
sGR=zeros(K+1,2);
sGR(1,:)=[1 size(sKData,1)];
for i=1:(numel(KGroupLimits)-1)
    sGR(i+1,1)=KGroupLimits(i);
    sGR(i+1,2)=KGroupLimits(i+1)-1;
end
sGRLabel=cell(size(sGR,1),1);
sGRLabel{1}='Full Set';
for i=1:K
    sGRLabel{i+1}=sprintf('Group %i',i);
end

end

