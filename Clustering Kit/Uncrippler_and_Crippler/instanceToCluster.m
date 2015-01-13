function [clusterNumber,numValidInstances]=instanceToCluster(instance)
%feed it an instance(1x23 char array), it will return a cluster number
%you'll need to have the Wmean100run.mat and centroid.mat in your directory for it to work
%numvalidInstances is just here for indication and is just a count of the
%values that are not missing
load('Wmean100run.mat');
load('centroids.mat');

%first, we can't consider the missing values.
%Let's search them. Missing values are cast to uint8 63

indexMissing=find(instance==63);
nmAt=23;%number of attributes
nmCl=22;%number of clusters

numValidInstances=nmAt-numel(indexMissing);
thingsWeCanStillConsider=zeros(numValidInstances,1);
cnt=1;
for i=1:nmAt
    if ~ismember(i,indexMissing)
        thingsWeCanStillConsider(cnt)=i;
        cnt=cnt+1;
    end
end
WeightMatrix=finW(:,thingsWeCanStillConsider);
%we removed things, now we need to normalize so everything still sums up to
%one. Otherwise, it is not a similarity measure anymore.
for cc=1:nmCl
    WeightMatrix(cc,:)=WeightMatrix(cc,:)./sum(WeightMatrix(cc,:));
end
%Now we replicate the instance to put everything in a nice matrix form
instanceMatrix=repmat(instance,nmCl,1);
%kro for Kronecker
kroMatr=instanceMatrix==correctedclusterCent;
distanceMatrix=zeros(nmCl,1);
for cc=1:nmCl
    distanceMatrix(cc)=WeightMatrix(cc,:)*kroMatr(cc,thingsWeCanStillConsider)';
end
%Now let's find the cluster whose centroid we are the closest to
[~,clusterNumber]=max(distanceMatrix);
end