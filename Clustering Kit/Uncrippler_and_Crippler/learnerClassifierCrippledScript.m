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
%%
[corrAttr22,confusionMatrices2,minScores2,selectionVector2]=functionizedsimpleLearnerClassifier([4,5,2,22,21,18,3,7,8,9,13,14,16,17]);
dsf=size(confusionMatrices2,3);
verif=zeros(1,dsf);
    cM=confusionMatrices2;
    for j=1:dsf
        verif(j)=isdiag(cM(:,:,j));
    end
    titleSz=15;
figure('Name','Effect of the removal of cap color')
plot(minScores2,'-+','LineWidth',2)
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)
%title('Effect of the removal of cap color','FontSize',titleSz)
%title({'Effect of the removal of cap color and presence of bruises'},'FontSize',titleSz)
%title({'Effect of the removal of cap color,', ' presence of bruises and cap shape'},'FontSize',titleSz)
%title({'Effect of the removal of cap color, presence of bruises,','cap shape and population'},'FontSize',titleSz)
%title({'Effect of the removal of cap color, presence of bruises,','cap shape, population and spore print color'},'FontSize',titleSz)
%title({'Effect of the removal of cap color, presence of bruises, cap shape,' 'population ,spore print color and veil color'},'FontSize',titleSz)
%title({'Effect of the removal of all remaining candidates'},'FontSize',titleSz)
title({'Effect of the removal of everybody except stalk-color-above-ring'},'FontSize',titleSz)

xlim([1,dsf]);
