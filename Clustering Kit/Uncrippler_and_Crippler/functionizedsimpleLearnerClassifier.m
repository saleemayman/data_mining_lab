
%SimpleLearner Classifier

%Same as StupidClusterClassifier except that we try to learn the weights
%this time
function [corrAttr2,confusionMatrices,minScores,selectionVector]=functionizedsimpleLearnerClassifier(indexOfThingsToRemove)
%indexOfThingsToRemove=6;
disp('Workspace cleared and ready to go.');
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
%% Get the cluster modes
nmAt=size(Data,2);%num Attributes
nmCl=22;%num Clusters
nmInst=size(Data,1);%num Instances

[ sGR, sGRLabel,sKData1 ] = getGroupLimits( h22indices,22,Data);
[clusterCent,modesB,figHandle] = modeGroupGrapher(sKData1,sGR,Attributes,Labels,AttributesTypes,sGRLabel,false,'');
close all
correctedclusterCent=zeros(nmCl,size(clusterCent,1));
for atr=1:nmAt
    for cl=1:nmCl
    correctedclusterCent(cl,atr)=Attributes{atr}{clusterCent(cl+1,atr)};%cl+1: not the full set
    end
end

% %% VALIDATION by taking 1/8 of each cluster for validation
% clusters=cell(22,1);
% validData=cell(1,22);
% trainData=cell(22,1);
% validlabelcell=cell(22,1);%one field for the labels too
% trainlabelcell=cell(22,1);
% validsize=zeros(1,22);
% clSize=zeros(1,22);
% for i=1:22
%     clusters{i}=sKData1(sGR(i+1,1):sGR(i+1,2),:);
%     clSize(i)=size(clusters{i},1);
%     validsize(i)=ceil(clSize(i)/8.0);
%     shuffler2=randperm(clSize(i));
%     validData{i,1}=clusters{i}(shuffler2(1:validsize(i)),:);
%     validlabelcell{i,1}=(i*ones(1,validsize(i)))';
%     trainData{i,1}=clusters{i}(shuffler2((validsize(i)+1):end),:);
%     trainlabelcell{i,1}=(i*ones(size(shuffler2((validsize(i)+1):end))))';
% end
% validDataMat=cell2mat(validData);
% trainDataMat=cell2mat(trainData);
% validLabel=cell2mat(validlabelcell);
% trainLabel=cell2mat(trainlabelcell);
% 
% tic
% runsNb=1;
% W=ones(nmCl,nmAt,runsNb);%numGroup, numAttr,runsNb
% for runI=1:runsNb
%     %% Randomize the data Index
%     randindex=randperm(size(trainDataMat,1));
%     corrlabels=trainLabel(randindex);
%     randData=trainDataMat(randindex,:);
%     %% TRAINING
%     %trainlimit=[1 6500]; %approx 80 percent of the data;
%     trainlimit=[1 size(trainDataMat,1)];
%     %validlimit=[6501 8124];
%     validlimit=[1 size(validDataMat,1)];
%     %the weight matrix
%     
%     %if the attributes of a instance match the correct cluster mode:
%     truematchBonus=0.05;
%     %truematchBonus=0.95;
%     %if the attributes of a instance match a false cluster mode:
%     falsematchMalus=0.001;
%     %falsematchMalus=0.1;
%     
%     for ii=trainlimit(1):trainlimit(2)
%         instance=randData(ii,:);
%         instanceS=repmat(instance,nmCl,1);
%         kroMatr=instanceS==correctedclusterCent;
%         for cc=1:nmCl
%             if cc==corrlabels(ii)
%                 W(cc,:,runI)=W(cc,:,runI)+kroMatr(cc,:)*truematchBonus;
%             else
%                 W(cc,:,runI)=W(cc,:,runI)+kroMatr(cc,:)*falsematchMalus;
%             end
%             %W(cc,:,runI)=W(cc,:,runI)./sum(W(cc,:,runI));
%         end
%     end
%     for cc=1:nmCl
%        W(cc,:,runI)=W(cc,:,runI)./sum(W(cc,:,runI));
%     end
% end
% toc
% finW=mean(W,3);
load('Wmean100run.mat');
% 
% distanceMatrix=zeros(numel(validlimit(1):validlimit(2)),nmCl);
% for ii=validlimit(1):validlimit(2)
%     instance=validDataMat(ii,:);
%     instanceS=repmat(instance,nmCl,1);
%     kroMatr=instanceS==correctedclusterCent;
%     for cc=1:nmCl
%         distanceMatrix(ii,cc)=finW(cc,:)*kroMatr(cc,:)';
%     end
% end
distanceMatrix=zeros(numel(1:size(sKData1,1)),nmCl);
for ii=1:size(sKData1,1)
    instance=sKData1(ii,:);
    instanceS=repmat(instance,nmCl,1);
    kroMatr=instanceS==correctedclusterCent;
    for cc=1:nmCl
        distanceMatrix(ii,cc)=finW(cc,:)*kroMatr(cc,:)';
    end
end
% figure('Name','2')
% imagesc(distanceMatrix)
% title('Graphical representation of the learned similarity measure between the instances and the cluster modes')
% ylabel('Instance number')
% xlabel('Cluster number')

[A,I]=max(distanceMatrix,[],2);
Cl=1; 
scoreS=zeros(nmCl,1);
% for p=validlimit(1):validlimit(2)
%     if validLabel(p)==I(p)
%         scoreS(validLabel(p))=scoreS(validLabel(p))+1;
%     end
% end
trueLabel=sort(h22indices,'ascend');
for p=1:size(sKData1,1)
    if trueLabel(p)==I(p)
        scoreS(trueLabel(p))=scoreS(trueLabel(p))+1;
    end
end

%get the number of total instances per cluser (ground truth)
normalizI=zeros(22,1);
% for i=1:22
% normalizI(i)=numel(validlabelcell{i});
% end
for i=1:22
normalizI(i)=numel(find(h22indices==i));
end
%divide match for clusters by the number of total instances of that class
nscoreS=1./normalizI.*scoreS;
min(nscoreS)
confusionMatrix=zeros(nmCl);
% for ii=validlimit(1):validlimit(2)
%      truecl=validLabel(ii);
%      esticl=I(ii);
%      confusionMatrix(truecl,esticl)=confusionMatrix(truecl,esticl)+1;
% end
for ii=1:size(sKData1,1)
     truecl=trueLabel(ii);
     esticl=I(ii);
     confusionMatrix(truecl,esticl)=confusionMatrix(truecl,esticl)+1;
end
% figure();imagesc(finW);
% title('Trained Weight Matrix')
% ylabel('Clusters')
% xlabel('Attribute')
% colorbar
%--------------------------------------------------------------------------
%% Classification with less attributes
W=finW;
% what I want: compute min classif rate for each attribute that I take out.
% Then I take the best one, then remove one again and again
selectionVector=1:23;
for i=indexOfThingsToRemove
    selectionVector=selectionVector(find(selectionVector~=i));
end
selectionVector
combos=nchoosek(selectionVector,1);%lol
distanceMatrix=zeros(size(sKData1,1),nmCl,numel(combos));
for i=1:size(combos,1)
    selectionVector2=selectionVector(find(selectionVector~=combos(i)));
    crippledW=W(:,selectionVector2);
    %we need to normalize again
    for cc=1:nmCl
        crippledW(cc,:)=crippledW(cc,:)./sum(crippledW(cc,:));
    end
    %%then we compute the distanceMatrices
    for ii=1:size(sKData1,1)
        instance=sKData1(ii,:);
        instanceS=repmat(instance,nmCl,1);
        kroMatr=instanceS==correctedclusterCent;
        kroMatr=kroMatr(:,selectionVector2);
        for cc=1:nmCl
            distanceMatrix(ii,cc,i)=crippledW(cc,:)*kroMatr(cc,:)';
        end
    end
end
%% Now the validation!
confusionMatrices=zeros(nmCl,nmCl,numel(combos));
minScores=zeros(1,numel(combos));
for i=1:size(combos,1)
    [A,I]=max(distanceMatrix(:,:,i),[],2);
    Cl=1;
    scoreS=zeros(nmCl,1);
    for p=1:size(sKData1,1)
        if trueLabel(p)==I(p)
            scoreS(trueLabel(p))=scoreS(trueLabel(p))+1;
        end
    end
    
    %get the number of total instances per cluser (ground truth)
    normalizI=zeros(22,1);
    for ij=1:22
        normalizI(ij)=numel(find(h22indices==ij));
    end
    %divide match for clusters by the number of total instances of that class
    nscoreS=1./normalizI.*scoreS;
    minScores(i)=min(nscoreS);
    
    for ii=1:size(sKData1,1)
        truecl=trueLabel(ii);
        esticl=I(ii);
        confusionMatrices(truecl,esticl,i)=confusionMatrices(truecl,esticl,i)+1;
    end
end
%% We know that odor is kinda a pain. Let's remove it



bestDiscardStep=find(minScores>0.99999);
corrAttr=selectionVector(bestDiscardStep);
corrAttr2=AttributesTypes(corrAttr);
end