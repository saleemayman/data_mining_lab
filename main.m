%% Clean ALL THE THINGS!
clc
clearvars
close all
%% Load the datas, labels and stuff
run dataExtractor.m
%% Generate the graphs

%index of the attribute you want to plot
index=1;
[barInput,plotHandle]=simpleDescriptionGraphGenerator(index,Data,Attributes,Labels,AttributesTypes);

%Note: this is just to show you how it works. Feel free to modify it
%(put index in a loop, etc).