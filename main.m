%% Clean ALL THE THINGS!
clc
clearvars
close all
disp('Workspace cleared and ready to go.');
%% Load the datas, labels and stuff
run dataExtractor.m

disp('dataExtractor successful.');
%% Generate the graphs

%index of the attribute you want to plot
index=21;
[barInput,plotHandle,stDev]=simpleDescriptionGraphGenerator(index,Data,Attributes,Labels,AttributesTypes,true);

disp('Plots successfully generated.');
%Note: this is just to show you how it works. Feel free to modify it
%(put index in a loop, etc).?
%% Now let's look for clusters
indexAttr=1:23;
stDevs=zeros(numel(indexAttr),1);
barInputs=cell(numel(indexAttr),1);
for i=1:numel(indexAttr)
    [barInput,plotHandle,stDev]=simpleDescriptionGraphGenerator(indexAttr(i),Data,Attributes,Labels,AttributesTypes,true);
    stDevs(i)=stDev;
    barInputs{i}=barInput;
end

disp('Clustering complete.');
%% convert data into matrix form (8124x23 char matrix) for easy access
startIndex = 1;
endIndex = 10;
[dataMatrix, structAttributeData] = structAndMatrixDataGenerator(startIndex, endIndex);

disp('Data in matrix and struct array generated.');