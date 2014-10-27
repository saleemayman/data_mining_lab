%% Clean ALL THE THINGS!
clc
clearvars
close all
disp('Workspace cleared and ready to go.');
%% Load the datas, labels and stuff
run dataExtractor.m
disp('dataExtractor successful.');
%% Generate the graphs: * * * * * For a Single Attribute * * * * *

%index of the attribute you want to plot
index=1;
[barInput,plotHandle]=simpleDescriptionGraphGenerator(index,Data,Attributes,Labels,AttributesTypes);
disp('Distribution for attribute plotted and saved.');
%Note: this is just to show you how it works. Feel free to modify it

%% Generate the graphs: * * * * * For Multiple Attributes * * * * *

startIndex = 12;
endIndex = 17;

% loop through the above index range; plot the distributions and save each
% plot as a .png
for index = startIndex:endIndex
    
    [barInput, plotHandle] = simpleDescriptionGraphGenerator(index,...
        Data, Attributes, Labels, AttributesTypes);
    
end
disp('Distribution for attributes plotted and saved.');

