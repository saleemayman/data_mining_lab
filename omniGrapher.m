function [barInput,figHandle] = omniGrapher(index,Data,sgR,Attributes,Labels,AttributesTypes,GroupLabels,export,title)
%simpleDescriptionGraphGenerator_mat: generate a plot of the repartition of the
%values of attribute 'index' for all the different groups specified in
%subgroupRange.
%
%   INPUT:
%   index          : the one of the target attribute
%   Data           : MATRIX containing the different instances <<<<!
%   Attributes     : cell containing the different attributes values
%   Labels         : "    "          "   "         attributes labels
%   AttributesTypes: "    "          "   "         attributes types
%   GroupLabels    : "    "          "   "         group Labels
%   export         : bool, true if you desire additionaly to save the 
%                    figure as a eps file, false otherwise
%   sgR            : sub group range, size(subgroupRange,1)x2 Array 
%   containing the starting and the ending instance of each group. 
%   Possibility of overlap.
%   title          : title of the figure and of the graph
%   OUTPUT:
%   barInput: output of function attributes_counter(Attributes,Data,index)
%   for each of the subgroups in a size(subgroupRange,1)xnumAttr Array
%   figHandle: handle of the generated figure

barInput=zeros(size(sgR,1),numel(Attributes{index}));
for i=1:size(sgR,1)
    barInput(i,:)=attributes_counter_mat(index,Data(sgR(i,1):sgR(i,2),:),...
                Attributes);%creates the inventory of instances per value
    barInput(i,:)=barInput(i,:)/(1.0*size(Data(sgR(i,1):sgR(i,2)),2))*100;
    %Because percentages are great
end
nmAt=numel(Attributes{index});
nmGr=size(sgR,1);
%The concept is to create a bird's view of the bars, from the above
sizeBlock=24; %side length of the small squares in pixels
textBlock=20; %side length of the rectangle for text in pixels.
fontSz=16;    %Font Size of the text
grshiftR=1;   %How much the text must be shifted to the right. Otherwise right at 
%the border of the rectangle. For the group text column
lbshiftR=1;   %Same but for the labels
%Vertical size will be (sizeBlock+margin)*numel(Attributes{index})
figHandle=figure('Name',title);
%rectangle('Position',[1,1,(nmGr+1)*sizeBlock,(nmAt)*sizeBlock+textBlock])%background
axis off;
%% First the text
he=1;
for i=1:nmGr
    r=rectangle('Position',[1,he,textBlock,sizeBlock]);
    curp=r.Position;%current position of the rectangle
    tx=GroupLabels{i};
    text(curp(1)+grshiftR,round(curp(2)+sizeBlock/2),tx,'FontSize',fontSz);
    he=he+sizeBlock;
     
end
wi=textBlock+1;
for i=1:nmAt
    r=rectangle('Position',[wi,he,sizeBlock,sizeBlock]);
    curp=r.Position;
    tx=Labels{index}{i};
    text(curp(1)+lbshiftR,round(curp(2)+sizeBlock/2),tx,'FontSize',fontSz);
    wi=wi+sizeBlock;
end
%rectangle('Position',[1,1,sizeBlock,sizeBlock])
%% Then the info
he=1;
wi=textBlock+1;
%valRange=round(min(barInput(:)):max(barInput(:)));
%c=colormap(jet(numel(valRange)))
augmL=121;%we don't want the darker values
cut=0.12;%proportion of the colorbar we want to cut out
c=colormap(jet(augmL));%from 0 to 100
c=c(round(cut*augmL):augmL,:);
for j=1:nmGr
    for i=1:nmAt
        r=rectangle('Position',[wi,he,sizeBlock,sizeBlock]);
        r.FaceColor=c(round(barInput(j,i))+1,:);
        curp=r.Position;
        tx=sprintf('%0.1f',barInput(j,i));
        text(curp(1)+lbshiftR,round(curp(2)+sizeBlock/2),tx,'FontSize',fontSz);
        wi=wi+sizeBlock;
    end
    wi=textBlock+1;
    he=he+sizeBlock;
end
colorbar('Ticks',[0,1],...
         'TickLabels',{'0%','100%'})

end

