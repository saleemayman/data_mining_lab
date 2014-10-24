function [barInput,plotHandle] = simpleDescriptionGraphGenerator(index,Data,Attributes,Labels,AttributesTypes)
%simpleDescriptionGraphGenerator: generate a plot of the repartition of the
%values of attribute 'index'
%   index          : the one of the target attribute
%   Data           : cell containing the different instances
%   Attributes     : cell containing the different attributes
%   Labels         : "    "          "   "         attributes labels
%   AttributesTypes: "    "          "   "         attributes types
%
%   barInput: output of function attributes_counter(Attributes,Data,index)
%   plotHandle: handle of the generated plot



%creates histogram/'counter'
barInput=attributes_counter(index,Data,Attributes);
%percentages are great
barInput=barInput/(1.0*size(Data,1));
figure('Name',AttributesTypes{index})
hold on
plotHandle=bar(barInput);
title(sprintf('Distribution of the %s attribute',AttributesTypes{index}));
ylabel('Percentage of instances having the value')
end

