clearvars
close all
clc

fid = fopen('AdriensMushroom Processed.txt');
C = textscan(fid,'%s'); % Read data skipping header
fclose(fid);
numAttr=23;
SpecieVector=cell(numel(C{:}),1);
Data=zeros(numel(C{:}),numAttr);
for i=1:numel(C{:})
interm=strjoin(strsplit(C{:}{i},','),'');
SpecieVector{i}=interm(1:16);
interm=interm(17:end);
Data(i,:)=cast(interm,'uint8');
end
clusterAssigned=zeros(size(Data,1),1);
validInstanceCounter=zeros(size(Data,1),1);
for i=1:size(Data,1)
    [clusterAssigned(i),validInstanceCounter(i)]=...
                        instanceToCluster(Data(i,:));
    
    disp(sprintf('Sample %s assigned to cluster %i',SpecieVector{i},clusterAssigned(i)));
end