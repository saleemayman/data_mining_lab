function [barInput,plotHandle] = simpleDescriptionGraphGenerator_mat(index,Data,Attributes,Labels,AttributesTypes,export,subgroupRange)
%simpleDescriptionGraphGenerator_mat: generate a plot of the repartition of the
%values of attribute 'index'
%   index          : the one of the target attribute
%   Data           : MATRIX containing the different instances <<<<!
%   Attributes     : cell containing the different attributes values
%   Labels         : "    "          "   "         attributes labels
%   AttributesTypes: "    "          "   "         attributes types
%   export         : bool, true if you desire additionaly to save the 
%                    figure as a eps file, false otherwise
%   subgroupRange    : sub group range, tuple (start,end)
%   barInput: output of function attributes_counter(Attributes,Data,index)
%   plotHandle: handle of the generated plot



barInput=attributes_counter_mat(index,Data,Attributes);%creates the inventory of instances per value
barInput=barInput/(1.0*size(Data,1))*100;%percentages are great

%open a window with title AttributesTypes{index} to put our histogram in
f=figure('Name',AttributesTypes{index});
hold on
lineColorMap=colormap('lines');%lineColorMap is basically a dictionnary of colors
%% PLOTTING
plotHandle=cell(numel(Attributes{index}),1);%to stock all our different Handle
[barInputSorted,sortingIndex]=sort(barInput,'descend');
for i=1:numel(Attributes{index})
     plotHandle{i}=bar([i], barInputSorted(i),'FaceColor',lineColorMap(i,:));
end
value=125;%DEPENDS ON YOUR SCREEN SIZE-> param for width
f.Position=[f.Position(1),f.Position(2),f.Position(3)+value,f.Position(4)];%resize fig
%% MAKING THINGS PRETTY WITH UGLY CODE

%For underscores to be displayed as underscores
set(0, 'DefaulttextInterpreter', 'none');
%the title floating above the bars
title(sprintf('Distribution of the %s \n attribute values, instances %i to %i',AttributesTypes{index},subgroupRange(1),subgroupRange(2)),'FontSize',22);
%for the ordinate axis
ylabel('instances having the value, in %','FontSize',16)
xl=xlabel(sprintf('%s values',AttributesTypes{index}),'FontSize',15);
set(xl,'position',get(xl,'position')-[0 0.01 0]);
sortedLabels=Labels{index}(sortingIndex);
xlim([0.5 (numel(Attributes{index})+0.5)]);
set(gca,'XTick',1:numel(Attributes{index}));
set(gca,'XTickLabel',sortedLabels);
set(gca,'FontSize',14);
%add some info
%set(0, 'DefaulttextInterpreter', 'tex');%for sigma to be displayed
%h = axes('Position',[0 0 1 1],'Visible','off');
%str(1) = {'Standard Deviation:'};
%str(2) = {sprintf('%s = %.4f','\sigma',std(barInput))};
%set(gcf,'CurrentAxes',h)
%text(.65,.8,str,'FontSize',14)
%export the figure
if export
    exportFigureName=sprintf('%i_attribute_valDistrib_subg_%i_to_%i.eps',index,subgroupRange(1),subgroupRange(2));
    hgexport(gcf,exportFigureName, hgexport('factorystyle'), 'Format', 'eps');
    fprintf('Figure successfully exported as %s \n',exportFigureName);
end
end

