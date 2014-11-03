%SIMILARITY MATRIX EXPLOITATION Script
%
%In this script, the target is to use the similarity measure that we
%defined the first week, aka string compare, in order to find clusters in
%the data. As noticed, the data is apparently already structured. Let's see
%how.
%% Clean ALL THE THINGS!
clc
clearvars
close all
disp('Workspace cleared and ready to go.');
%% Load the datas, labels and stuff
tic
run betterDataExtractor.m
t=toc;
fprintf('betterDataExtractor successful, t=%0.4f s.\n',t);

%% Generate similarity matrix
disp('Please be patient :D (circa 160s)')
tic
S=simiStrCmpRefined( Data );%157 secondes circa
t=toc;
fprintf('Creation of the similarity matrix sucessful, %0.4 s\n',t);
%% Normalization, taking the missing values into account
S=S/23.0;%normalization

indexQ=find(Data(:,12) == cast('Q','uint8'));
for i=1:numel(indexQ)
    S(indexQ(i),:)=S(indexQ(i),:)*23/22;
    S(:,indexQ(i))=S(:,indexQ(i))*23/22;
end
% The diagonal won't be 1 because of the scheme so I correct that here:
S(eye(size(S))~=0)=1; 


%% NORMALIZATION SUPPRESS THE 1/1 diagonal as it yields only a bias
S=S-eye(size(S));
%% 
%issymmetric(S) 
groupLim=[1 1; 960 960; 2000 2000; 3887 3887; 6000 6000; 8125 8125];%8125 because of group limit
markedS=S;
for i=1:size(groupLim,1)-1
    margin=50;
    markedS(groupLim(i):groupLim(i)+margin,groupLim(i):groupLim(i+1))=0;
    markedS(groupLim(i):groupLim(i+1),groupLim(i):groupLim(i)+margin)=0;
    
    markedS(groupLim(i+1):groupLim(i+1)+margin,groupLim(i):groupLim(i+1))=0;
    markedS(groupLim(i):groupLim(i+1),groupLim(i+1):groupLim(i+1)+margin)=0;
end
markedS=markedS(1:8124,1:8124);
imshow(markedS);
colormap('jet');

%%
%group 1:1-960
%group 2:960-2000;
%group 3:2000-3887;
%group 4:3887-6030;
%group 5:6000-end;
numGroup=5;
group=cell(numGroup,1);
showMeAllTheThings=true;%display the shitty suplot of the groups
group{1}=S(1:960,1:960);
group{2}=S(960:2000,960:2000);
group{3}=S(2000:3887,2000:3887);
group{4}=S(3887:6000,3887:6000);
group{5}=S(6000:end,6000:end);
if showMeAllTheThings
    figure('Name','Groups')
    subplot(3,2,1)
    imshow(group{1});
    colormap('jet');
    
    subplot(3,2,2)
    imshow(group{2});
    colormap('jet');
    
    subplot(3,2,3)
    imshow(group{3});
    colormap('jet');
    
    subplot(3,2,4)
    imshow(group{4});
    colormap('jet');
    
    subplot(3,2,5)
    imshow(group{5});
    colormap('jet');
end
%% FIND THE OUTLIERS
ScoresS=sum(S)/8123;%because itself is 0
[SortScores,IScore]=sort(ScoresS);
figure('Name','Sorted S')
hist(SortScores)
hold on
title('Repartition of the similarity scores globally');
ylabel('Number of Instances')
xlabel('Similarity Score')
hold off
%%IScore contains all instances in descending order hence
% IScore(1:10) provides the ten instances with worst simil to everybody

%% FIND THE OUTLIERS FOR THE SUBGROUPS TOO
for i=1:numGroup
ScoresS=sum(group{i})/(size(group{i},1)-1);
[SortScores,IScore]=sort(ScoresS);
figure('Name',sprintf('Sorted Sgroup{%i}',i))
hist(SortScores)
hold on
title(sprintf('Repartition of the similarity scores for group %i',i));
ylabel('Number of Instances')
xlabel('Similarity Score')
hold off
end
%%  Now, we do the same thing as the first week, but for each subgroup
%redefinition is needed because we need 0 0 index
numGroup=5;
groupLim=[0 0; 960 960; 2000 2000; 3887 3887; 6000 6000; 8124 8124];
D_group=cell(numGroup,1);
for i=1:numGroup
    D_group{i}=Data(groupLim(i,1)+1:(groupLim(i+1,1)),:);
end
%SUMS UP TO 8124!!! FINALLY
attributeCounter=cell(numGroup,1);
plotHandlers=cell(numGroup,1);
disp('Please be patient :D (circa 160s)')
tic
for g=1:numGroup
 for i=1:23
 %to export (aka create files and not just plot in matlab) just change this
 %value to true
 export=false;
 [attributeCounter{g},plotHandlers{g}]=simpleDescriptionGraphGenerator_mat(i,D_group{g},...
     Attributes,Labels,AttributesTypes,false,[groupLim(g,1)+1,...
     (groupLim(g+1,1))]);
 set(gcf, 'Visible', 'off') %don't wanna all these figures in my face 23*numGroup
 end
 t=toc;
 fprintf('simpleDescriptionGraphGenerator_mat successful for group %i, t=%0.4f s.\n',g,t);
end
%% TO OPEN ONE OF THE FIGURES
numGroup=3;
numAttrib=7;
figure((numGroup-1)*23+numAttrib)