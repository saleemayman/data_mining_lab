function cripplerMinimalScheme()

titleSz=18;
%--------------------------------------------------------------------------
Steps=22;
confusionMatrices=cell(Steps,1);
truePos=cell(Steps,1);
%%
tic
run betterDataExtractor.m
t=toc;
fprintf('betterDataExtractor successful, t=%0.4f s.\n',t);
%% Start With Nothing
currStep=1;
indexOfThingsToAdd=[];
[confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz);
%%
currStep=2;
indexOfThingsToAdd=15;
[confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz);
%%
indexOfThingsToAdd=[15,6];
currStep=3;
[confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz);
%%
indexOfThingsToAdd=[23,15,6];
currStep=4;
[confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz);
%%
indexOfThingsToAdd=[23,22,15,6];
currStep=5;
[confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz);
%%
indexOfThingsToAdd=[23,22,15,6,1];
currStep=6;
[confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz);
%%
indexOfThingsToAdd=[23,22,15,14,6,1];
currStep=7;
[confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz);
%%
indexOfThingsToAdd=[23,22,15,14,9,6,1];
currStep=8;
[confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz);
%%
indexOfThingsToAdd=[23,22,15,14,9,6,3,1];
currStep=9;
[confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz);
%%
indexOfThingsToAdd=[23,22,15,14,11,9,6,3,1];
currStep=10;
[confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz);
end
function [confusionMatrices,truePos]=SpecialPlot(currStep,indexOfThingsToAdd,confusionMatrices,truePos,AttributesTypes,titleSz)
AttributesTypesMod=AttributesTypes;
for o=1:numel(indexOfThingsToAdd)
  AttributesTypesMod(indexOfThingsToAdd(o))=[];
end
[confusionMatrices{currStep},truePos{currStep}]=uncripplerClassifier(indexOfThingsToAdd);

f=figure('Name',sprintf('Mean Performance, number of attributes used: %i',currStep));
plot(mean(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Mean Performance for all clusters, number of attributes used: %i',currStep),'FontSize',titleSz);
xlabel('Added Attribute Index','FontSize',titleSz)
ylabel('Mean Classification Rate','FontSize',titleSz)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
hgexport(f,strcat(sprintf('MinSchemecurrStep_%i',currStep),'_meanclassifscore.png'),...
                                 hgexport('factorystyle'),'Format','png');
h=figure('Name',sprintf('Min Performance, number of attributes used: %i',currStep));
plot(min(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Min Performance for all clusters, number of attributes used: %i',currStep),'FontSize',titleSz);
xlabel('Added Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate on all clusters','FontSize',titleSz)
set(gcf,'units','normalized','outerposition',[0 0 1 1])
hgexport(h,strcat(sprintf('MinSchemecurrStep_%i',currStep),'_minclassifscore.png'),...
                                 hgexport('factorystyle'),'Format','png');
[A,I]=max(min(truePos{currStep}));
disp(sprintf('Highest Score is attribute number %i, %s',I,AttributesTypesMod{I}))


end