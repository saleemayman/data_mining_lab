clear all
close all
clc
titleSz=15;
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
[confusionMatrices{currStep},truePos{currStep}]=uncripplerClassifier(indexOfThingsToAdd);

figure('Name',sprintf('Mean Performance for %i attribute',currStep))
plot(mean(truePos{currStep},1),'-+','LineWidth',2)
title(sprintf('Mean Performance for %i attribute',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

figure('Name',sprintf('Min Performance for %i attribute',currStep))
plot(min(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Min Performance for %i attribute',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

[A,I]=max(mean(truePos{currStep}))
disp(sprintf('Highest Score is attribute number %i, %s',I,AttributesTypes{I}))
% figure('Name',sprintf('Performance for %i attribute',currStep))
% 
% legendContent=cell(1,22);
% colorm=hsv(22);
% for i=1:22
%     hold all
%     plot(truePos{currStep}(i,:),'-+','LineWidth',2,'Color',colorm(i,:))
%     legendContent{i}=sprintf('Cluster %i',i);
% end
% title(sprintf('Performance for %i attribute for the different clusters',currStep),'FontSize',titleSz);
% xlabel('Remaining Attribute Index','FontSize',titleSz)
% ylabel('Classification Rate','FontSize',titleSz)
% legend(legendContent);
% hold off


%%
indexOfThingsToAdd=15;
AttributesTypesMod=AttributesTypes;
for o=1:numel(indexOfThingsToAdd)
  AttributesTypesMod(indexOfThingsToAdd(o))=[];
end
currStep=2;
[confusionMatrices{currStep},truePos{currStep}]=uncripplerClassifier(indexOfThingsToAdd);

figure('Name',sprintf('Mean Performance for %i attributes',currStep))
plot(mean(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Mean Performance for %i attributes',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

figure('Name',sprintf('Min Performance for %i attribute',currStep))
plot(min(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Min Performance for %i attribute',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

[A,I]=max(mean(truePos{currStep}))
disp(sprintf('Highest Score is attribute number %i, %s',I,AttributesTypesMod{I}))
indexOfThingsToAdd=15;
AttributesTypesMod=AttributesTypes;
for o=1:numel(indexOfThingsToAdd)
  AttributesTypesMod(indexOfThingsToAdd(o))=[];
end
%%
indexOfThingsToAdd=[15,6];
AttributesTypesMod=AttributesTypes;
for o=1:numel(indexOfThingsToAdd)
  AttributesTypesMod(indexOfThingsToAdd(o))=[];
end
currStep=3;
[confusionMatrices{currStep},truePos{currStep}]=uncripplerClassifier(indexOfThingsToAdd);

figure('Name',sprintf('Mean Performance for %i attributes',currStep))
plot(mean(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Mean Performance for %i attributes',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

figure('Name',sprintf('Min Performance for %i attribute',currStep))
plot(min(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Min Performance for %i attribute',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

[A,I]=max(mean(truePos{currStep}))
disp(sprintf('Highest Score is attribute number %i, %s',I,AttributesTypesMod{I}))
%%
indexOfThingsToAdd=[23,15,6];
AttributesTypesMod=AttributesTypes;
for o=1:numel(indexOfThingsToAdd)
  AttributesTypesMod(indexOfThingsToAdd(o))=[];
end
currStep=4;
[confusionMatrices{currStep},truePos{currStep}]=uncripplerClassifier(indexOfThingsToAdd);

figure('Name',sprintf('Mean Performance for %i attributes',currStep))
plot(mean(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Mean Performance for %i attributes',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

figure('Name',sprintf('Min Performance for %i attribute',currStep))
plot(min(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Min Performance for %i attribute',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

[A,I]=max(mean(truePos{currStep}))
disp(sprintf('Highest Score is attribute number %i, %s',I,AttributesTypesMod{I}))
%%
indexOfThingsToAdd=[23,21,15,6];
AttributesTypesMod=AttributesTypes;
for o=1:numel(indexOfThingsToAdd)
  AttributesTypesMod(indexOfThingsToAdd(o))=[];
end
currStep=5;
[confusionMatrices{currStep},truePos{currStep}]=uncripplerClassifier(indexOfThingsToAdd);

figure('Name',sprintf('Mean Performance for %i attributes',currStep))
plot(mean(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Mean Performance for %i attributes',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

figure('Name',sprintf('Min Performance for %i attribute',currStep))
plot(min(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Min Performance for %i attribute',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

[A,I]=max(mean(truePos{currStep}))
disp(sprintf('Highest Score is attribute number %i, %s',I,AttributesTypesMod{I}))
%%
indexOfThingsToAdd=[23,21,15,6,1];
AttributesTypesMod=AttributesTypes;
for o=1:numel(indexOfThingsToAdd)
  AttributesTypesMod(indexOfThingsToAdd(o))=[];
end
currStep=6;
[confusionMatrices{currStep},truePos{currStep}]=uncripplerClassifier(indexOfThingsToAdd);

figure('Name',sprintf('Mean Performance for %i attributes',currStep))
plot(mean(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Mean Performance for %i attributes',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

figure('Name',sprintf('Min Performance for %i attribute',currStep))
plot(min(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Min Performance for %i attribute',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

[A,I]=max(mean(truePos{currStep}))
disp(sprintf('Highest Score is attribute number %i, %s',I,AttributesTypesMod{I}))
%%
indexOfThingsToAdd=[23,21,15,11,6,1];
AttributesTypesMod=AttributesTypes;
for o=1:numel(indexOfThingsToAdd)
  AttributesTypesMod(indexOfThingsToAdd(o))=[];
end
currStep=7;
[confusionMatrices{currStep},truePos{currStep}]=uncripplerClassifier(indexOfThingsToAdd);

figure('Name',sprintf('Mean Performance for %i attributes',currStep))
plot(mean(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Mean Performance for %i attributes',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

figure('Name',sprintf('Min Performance for %i attribute',currStep))
plot(min(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Min Performance for %i attribute',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

[A,I]=max(mean(truePos{currStep}))
disp(sprintf('Highest Score is attribute number %i, %s',I,AttributesTypesMod{I}))
%%
indexOfThingsToAdd=[23,21,15,11,9,6,1];
AttributesTypesMod=AttributesTypes;
for o=1:numel(indexOfThingsToAdd)
  AttributesTypesMod(indexOfThingsToAdd(o))=[];
end
currStep=8;
[confusionMatrices{currStep},truePos{currStep}]=uncripplerClassifier(indexOfThingsToAdd);

figure('Name',sprintf('Mean Performance for %i attributes',currStep))
plot(mean(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Mean Performance for %i attributes',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

figure('Name',sprintf('Min Performance for %i attribute',currStep))
plot(min(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Min Performance for %i attribute',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

[A,I]=max(mean(truePos{currStep}))
disp(sprintf('Highest Score is attribute number %i, %s',I,AttributesTypesMod{I}))
%%
indexOfThingsToAdd=[23,21,15,12,11,9,6,1];
AttributesTypesMod=AttributesTypes;
for o=1:numel(indexOfThingsToAdd)
  AttributesTypesMod(indexOfThingsToAdd(o))=[];
end
currStep=9;
[confusionMatrices{currStep},truePos{currStep}]=uncripplerClassifier(indexOfThingsToAdd);

figure('Name',sprintf('Mean Performance for %i attributes',currStep))
plot(mean(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Mean Performance for %i attributes',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

figure('Name',sprintf('Min Performance for %i attribute',currStep))
plot(min(truePos{currStep}),'-+','LineWidth',2)
title(sprintf('Min Performance for %i attribute',currStep),'FontSize',titleSz);
xlabel('Remaining Attribute Index','FontSize',titleSz)
ylabel('Worst Classification Rate','FontSize',titleSz)

[A,I]=max(mean(truePos{currStep}))
disp(sprintf('Highest Score is attribute number %i, %s',I,AttributesTypesMod{I}))