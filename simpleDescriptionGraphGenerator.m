function [barInput,plotHandle,stDev] = simpleDescriptionGraphGeneratorNew(index,Data,Attributes,Labels,AttributesTypes,export)
%simpleDescriptionGraphGenerator: generate a plot of the repartition of the
%values of attribute 'index'
%   index          : the one of the target attribute
%   Data           : cell containing the different instances
%   Attributes     : cell containing the different attributes values
%   Labels         : "    "          "   "         attributes labels
%   AttributesTypes: "    "          "   "         attributes types
%   export         : bool, true if you desire additionaly to save the 
%                    figure as a eps file, false otherwise
%   barInput: output of function attributes_counter(Attributes,Data,index)
%   plotHandle: handle of the generated plot
%   stDev: standard deviation of the normalized instance per value vector

barInput=attributes_counter(index,Data,Attributes);%creates the inventory of instances per value
barInput=barInput/(1.0*size(Data,1));%percentages are great
stDev=std(barInput);%standard deviation

%open a window with title AttributesTypes{index} to put our histogram in
<<<<<<< HEAD
f=figure('Name',AttributesTypes{index});
hold on
lineColorMap=colormap('lines');%lineColorMap is basically a dictionnary of colors
%% PLOTTING
plotHandle=cell(numel(Attributes{index}),1);%to stock all our different Handle
[barInputSorted,sortingIndex]=sort(barInput,'descend');
for i=1:numel(Attributes{index})
     plotHandle{i}=bar([i], barInputSorted(i),'FaceColor',lineColorMap(i,:));
end
f.Position=[f.Position(1),f.Position(2),f.Position(3)+125,f.Position(4)];%resize fig
%% MAKING THINGS PRETTY WITH UGLY CODE

%For underscores to be displayed as underscores
set(0, 'DefaulttextInterpreter', 'none');
%the title floating above the bars
title(sprintf('Distribution of the %s \n attribute values',AttributesTypes{index}),'FontSize',22);
%for the ordinate axis
ylabel('instances having the value, in %','FontSize',16)
xl=xlabel(sprintf('%s values',AttributesTypes{index}),'FontSize',15);
set(xl,'position',get(xl,'position')-[0 0.01 0]);
sortedLabels=Labels{index}(sortingIndex);
xlim([0.5 (numel(Attributes{index})+0.5)]);
set(gca,'XTick',1:numel(Attributes{index}));
set(gca,'XTickLabel',sortedLabels);
set(gca,'FontSize',14);

%export the figure
if export
    exportFigureName=sprintf('%i_attribute_valDistrib.eps',index);
    hgexport(gcf,exportFigureName, hgexport('factorystyle'), 'Format', 'eps');
    fprintf('Figure successfully exported as %s \n',exportFigureName);
end
=======
hFig = figure('Name',AttributesTypes{index});   % hFig is the figure handle
                                                % for saving the figure

plotHandle=bar(barInput);%creates our Histogram
hold on;%means we can still add options to our Histogram

%an nice title floating above the bars
title(sprintf('Distribution of the %s attribute',AttributesTypes{index}));

%for the ordinate axis
ylabel('Percentage of instances having the value')

%Labels under the graphs
set(gca,'XTickLabel',Labels{index})

% create filename for attribute figure
figFileName = [num2str(index) '_' AttributesTypes{index}];
saveas(hFig, figFileName, 'png')

>>>>>>> 9e73a0ec78e75000fa0f4bbd0c5e6a1cdfbc1bc7
end

