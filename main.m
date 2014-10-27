%% Clean ALL THE THINGS!
clc
clearvars
close all
%% Load the datas, labels and stuff
run dataExtractor.m
%% Generate the graphs

%index of the attribute you want to plot
index=21;
[barInput,plotHandle,stDev]=simpleDescriptionGraphGeneratorNew(index,Data,Attributes,Labels,AttributesTypes,true);

%Note: this is just to show you how it works. Feel free to modify it
%(put index in a loop, etc).?
%% Now let's look for clusters
indexAttr=1:23;
stDevs=zeros(numel(indexAttr),1);
barInputs=cell(numel(indexAttr),1);
for i=1:numel(indexAttr)
    [barInput,plotHandle,stDev]=simpleDescriptionGraphGeneratorNew(indexAttr(i),Data,Attributes,Labels,AttributesTypes,true);
    stDevs(i)=stDev;
    barInputs{i}=barInput;
end
%% Work!
close all
[sortedStDevs, indexStd]=sort(stDevs,'descend');
sortAttrIndex=indexAttr(indexStd);
sortedNames=cell(numel(sortAttrIndex),1);
for j=1:numel(sortAttrIndex)
    sortedNames{j}=AttributesTypes{sortAttrIndex(j)};
end
%TOP THREE
num=10;
fprintf('top %i are:',num);
for i=1:num
    fprintf('%i# %s (%i),std=%.4f \n',i,sortedNames{i},sortAttrIndex(i),sortedStDevs(i));
end

%create matrix with the three coordinates
visuCoords=zeros(numel(Data),3);
for k=1:numel(Data)
    visuCoords(k,:)=[Data{k}{sortAttrIndex(2)},...
                 Data{k}{sortAttrIndex(3)},...
                 Data{k}{sortAttrIndex(4)}];
             
    
end
%Now counts how many similar
[uniqueCoords,ivC,iuC]=unique(visuCoords,'rows');
% all the different  functions are tricky, hence
counter=zeros(size(uniqueCoords,1),1);
colors = autumn(size(uniqueCoords,1));
for i=1:size(uniqueCoords,1)
    for j=1:size(visuCoords,1)
        if isequal(uniqueCoords(i,:),visuCoords(j,:))
            counter(i)=counter(i)+1;
        end
    end
end
[sortedCounter,indxsC]=sort(counter);
sortUnqCoords=uniqueCoords(indxsC,:);
scatter3(sortUnqCoords(:,1),sortUnqCoords(:,2),sortUnqCoords(:,3),sortedCounter,colors,'filled')
colorbar%('YTick', unique(sortedCounter), 'YTickLabel', 1:numel(unique(sortedCounter)));
%scatter3(uniqueCoords(:,1),uniqueCoords(:,2),uniqueCoords(:,3),counter,colors,'filled')
%plot3(visuCoords(:,1),visuCoords(:,2),visuCoords(:,3),'.r')
%scatter3(visuCoords(:,1),visuCoords(:,1),visuCoords(:,1),ones(size(x)),data,'filled')
%scatter3(x,y,z,data.^-2,data,'filled')

% for i=1:23 
%     disp(i) 
%     sum(barInputs{i}) 
% end 