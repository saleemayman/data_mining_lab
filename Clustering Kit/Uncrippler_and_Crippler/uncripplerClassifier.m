function [confusionMatrices,truePos]=uncripplerClassifier(indexOfThingsToAdd)
%Okay, so we need something to add the different attributes and check the
%increase in performance
%% Load the datas, labels and stuff
tic
run betterDataExtractor.m
t=toc;
fprintf('betterDataExtractor successful, t=%0.4f s.\n',t);
%% Load the indexes, labels and cluster limits
load('22groupIndex.mat');%h22indices
h22labels=load('22groupLabels.mat');
h22labels=h22labels.sGRLabel;
h22limits=load('22groupLim.mat');
h22limits=h22limits.sGR;
load('22datasorted.mat')%h22sorteddata
nmAt=size(Data,2);%num Attributes
nmCl=22;%num Clusters
nmInst=size(Data,1);%num Instances
[ sGR, sGRLabel,sKData1 ] = getGroupLimits( h22indices,22,Data);
%the following is just a lazy way to get clusterCent
[clusterCent,modesB,figHandle] = modeGroupGrapher(sKData1,sGR,Attributes,Labels,AttributesTypes,sGRLabel,false,'');
close(figHandle)

correctedclusterCent=zeros(nmCl,size(clusterCent,1));

for atr=1:nmAt
    for cl=1:nmCl
        correctedclusterCent(cl,atr)=Attributes{atr}{clusterCent(cl+1,atr)};%cl+1: not the full set
    end
end
trueLabel=sort(h22indices,'ascend');

%% Load the Weights
load('Wmean100run.mat');

% Which are the attributes that we can still add i.e. that we haven't added
% already? There are 23 attributes.
thingsWeCanStillAdd=zeros(nmAt-numel(indexOfThingsToAdd),1);
cnt=1;
for i=1:nmAt
    if ~ismember(i,indexOfThingsToAdd)
        thingsWeCanStillAdd(cnt)=i;
        cnt=cnt+1;
    end
end


%% Compute the different required Weight matrices
distanceMatrix=zeros(nmInst,nmCl,numel(thingsWeCanStillAdd));
confusionMatrices=zeros(nmCl,nmCl,numel(thingsWeCanStillAdd));
truePos=zeros(nmCl,numel(thingsWeCanStillAdd));

for k=1:numel(thingsWeCanStillAdd)
    attr=thingsWeCanStillAdd(k);
    attributeConsidered=cat(2,indexOfThingsToAdd,attr);
    currW=finW(:,attributeConsidered);
    for cc=1:nmCl
        currW(cc,:)=currW(cc,:)./sum(currW(cc,:));
    end
    for ii=1:nmInst
        instance=sKData1(ii,:);
        instanceS=repmat(instance,nmCl,1);
        kroMatr=instanceS==correctedclusterCent;
        for cc=1:nmCl
            distanceMatrix(ii,cc,k)=currW(cc,:)*kroMatr(cc,attributeConsidered)';
        end
    end
    [A,I]=max(distanceMatrix(:,:,k),[],2);
    for ii=1:nmInst
        truecl=trueLabel(ii);
        esticl=I(ii);
        confusionMatrices(truecl,esticl,k)=confusionMatrices(truecl,esticl,k)+1;
    end
    for ccc=1:nmCl
        truePos(ccc,k)=confusionMatrices(ccc,ccc,k)./sum(confusionMatrices(ccc,:,k));
    end
end
end
