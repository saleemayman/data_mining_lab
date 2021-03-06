%% Clean ALL THE THINGS!
clc
clearvars
close all
disp('Workspace cleared and ready to go.');
%% Load the datas, labels and stuff
run dataExtractor.m
disp('dataExtractor successful.');
%% Data Analysis

%The distribution of the characteristics shall be printed in numbers on the
%console

nrSamples=numel(Data); %number of samples/lines

%Calculate the probability distribution of the characteristics per
%attribute
for i=1:23
    barInput{i}=attributes_counter(i,Data,Attributes);
    barInput{i}=barInput{i}/(nrSamples);
%     disp(AttributesTypes{i});
%     disp(barInput{i});
%     disp(Labels{i});
%     disp(Attributes{i});
end

%count variables for similarity
countSurface = 0;
countColor = 0;

for i=1:nrSamples %comparing similarity of Stalk Surface + Stalk color above + below ring.
    if Data{i}{13} == Data{i}{14}
        countSurface=countSurface +1;
    end
    if Data{i}{15} == Data{i}{16}
        countColor=countColor+13;
    end
end

disp(countSurface/nrSamples);
disp(countColor/nrSamples);

%% Data Manipulation

% 1. Delete redundant features which are:
%       

for i=1:nrSamples % go through samples and delete the 7th, 17th and 18th attribute
    Data{i} = Data{i}{1:6}+Data{i}{
        countSurface=countSurface +1;
    end
    if Data{i}{15} == Data{i}{16}
        countColor=countColor+13;
    end
end

