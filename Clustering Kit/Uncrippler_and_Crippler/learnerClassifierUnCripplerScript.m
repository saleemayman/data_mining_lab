clear all
close all
clc
%--------------------------------------------------------------------------
CorrAttr2=cell(23,1);
confusionMatrices=cell(23,1);
minScores=cell(23,1);
selectionVector=cell(23,1);
for i=1:23
    fprintf('Computing step %i',i)
    [corrAttr2{i},confusionMatrices{i},minScores{i},selectionVector{i}]=...
                                  functionizedsimpleLearnerClassifier(i);
end
%% Load the datas, labels and stuff
tic
run betterDataExtractor.m
t=toc;
fprintf('betterDataExtractor successful, t=%0.4f s.\n',t);
minminScore=zeros(1,23);
maxminScore=zeros(1,23);
for i=1:23
    minminScore(i)=min(minScores{i});
    maxminScore(i)=max(minScores{i});
end
