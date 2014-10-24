function [barInput,plotHandle] = simpleDescriptionGraphGenerator(index,Data,Attributes,Labels,AttributesTypes)
%simpleDescriptionGraphGenerator: generate a plot of the repartition of the
%values of attribute 'index'
%   index          : the one of the target attribute
%   Data           : cell containing the different instances
%   Attributes     : cell containing the different attributes values
%   Labels         : "    "          "   "         attributes labels
%   AttributesTypes: "    "          "   "         attributes types
%
%   barInput: output of function attributes_counter(Attributes,Data,index)
%   plotHandle: handle of the generated plot




barInput=attributes_counter(index,Data,Attributes);%creates the inventory of instances per value
barInput=barInput/(1.0*size(Data,1));%percentages are great

%open a window with title AttributesTypes{index} to put our histogram in
figure('Name',AttributesTypes{index})

plotHandle=bar(barInput);%creates our Histogram
hold on;%means we can still add options to our Histogram

%an nice title floating above the bars
title(sprintf('Distribution of the %s attribute',AttributesTypes{index}));
%for the ordinate axis
ylabel('Percentage of instances having the value')
%Labels under the graphs
set(gca,'XTickLabel',Labels{index})
end

