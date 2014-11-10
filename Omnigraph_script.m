%Omnigrapher tester
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
%% Group Building
 close all
sgR=     [1    8124;...   %full group
          1    960;...    %1
          961  2000;... %2
          2001 3887;...%3
          3888 6000;...%4
          6001 8124];  %5
GroupLabels=cell(size(sgR,1),1);
GroupLabels{1}='Full Set';
GroupLabels{2}='Group 1';
GroupLabels{3}='Group 2';
GroupLabels{4}='Group 3';
GroupLabels{5}='Group 4';
GroupLabels{6}='Group 5';
index=2;
export=false;
title=sprintf('Distribution of the %s attribute',AttributesTypes{index});
[barInput,figHandle]=omniGrapher(index,Data,sgR,Attributes,Labels,AttributesTypes,GroupLabels,export,title);
%%
for index=1:23
    export=false;
    title=sprintf('Distribution of the %s attribute',AttributesTypes{index});
    [barInput,figHandle]=omniGrapher(index,Data,sgR,Attributes,Labels,AttributesTypes,GroupLabels,export,title);

end