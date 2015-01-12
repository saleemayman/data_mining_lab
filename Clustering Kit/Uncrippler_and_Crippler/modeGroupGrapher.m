function [indMode,modesB,figHandle] = modeGroupGrapher(Data,sgR,Attributes,Labels,AttributesTypes,GroupLabels,export,a_title)
%modeGroupGrapher: generate a plot of the repartition of the
%values of attribute 'index' for all the different groups specified in
%subgroupRange.
%
%   INPUT:
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
%   a_title          : title of the figure and of the graph
%   OUTPUT:
%   barInput: output of function attributes_counter(Attributes,Data,index)
%   for each of the subgroups in a size(subgroupRange,1)xnumAttr Array
%   figHandle: handle of the generated figure
modesB=zeros(size(sgR,1),23);
indMode=zeros(size(sgR,1),23);
for k=1:23
%barInput=zeros(size(sgR,1),numel(Attributes{k}));
for i=1:size(sgR,1)
    BI=attributes_counter_mat(k,Data(sgR(i,1):sgR(i,2),:),...
                Attributes);%creates the inventory of instances per value
    BI=BI/(1.0*size(Data(sgR(i,1):sgR(i,2)),2))*100;
    %Because percentages are great
    [fsd, idexMax]=max(BI);
    modesB(i,k)=fsd(1);
    indMode(i,k)=idexMax(1);
end

end
shift=129;
labelsiz=81;
nmAt=23;
nmGr=size(sgR,1);
%figHandle.Position=[figHandle.Position(1),figHandle.Position(2),figHandle.Position(3)+valueW,figHandle.Position(4)+valueH];%resize figThe concept is to create a bird's view of the bars, from the above
sizeBlock=24; %side length of the small squares in pixels
textBlock=20; %side length of the rectangle for text in pixels.
fontSz=13;    %Font Size of the text
grshiftR=1;   %How much the text must be shifted to the right. Otherwise right at 
%the border of the rectangle. For the group text column
lbshiftR=1;   %Same but for the labels
%Vertical size will be (sizeBlock+margin)*numel(Attributes{index})
figHandle=figure('Name',a_title);
valueW=(nmAt+2)^1.5*sizeBlock; %param for width
valueH=(nmGr+2)*sizeBlock;%height
figHandle.Position=[figHandle.Position(1),figHandle.Position(2),figHandle.Position(3)+valueW,figHandle.Position(4)+valueH];%resize fig
axis ij; %set the origin to the upper right corner
axis off;
t=title(a_title,'interpreter','none');
%% First the text
grouShi=20;
he=shift+sizeBlock+labelsiz;
for i=1:nmGr
    r=rectangle('Position',[1-grouShi,he,textBlock+grouShi,sizeBlock]);
    curp=r.Position;%current position of the rectangle
    tx=GroupLabels{i};
    text(curp(1)+grshiftR,round(curp(2)+sizeBlock/2),tx,'FontSize',fontSz-3);
    he=he+sizeBlock;
     
end
wi=textBlock+1;
he=shift;
for i=1:nmAt+1
    if i<=nmAt
    r=rectangle('Position',[wi,he-sizeBlock,sizeBlock,129]);
    curp=r.Position;
    tx=AttributesTypes{i};
    text(curp(1)+curp(3)/2,curp(2)+curp(4)-2,tx,'FontSize',fontSz-2,...
            'Rotation',90,'Interpreter','none');
    wi=wi+sizeBlock;
    else
     r=rectangle('Position',[wi,he-sizeBlock,sizeBlock,129]);
    curp=r.Position;
    tx='Relative size of the group';
    text(curp(1)+curp(3)/2,curp(2)+curp(4)-2,tx,'FontSize',fontSz-2,...
            'Rotation',90,'Interpreter','none');
    wi=wi+sizeBlock;
    end
end
%rectangle('Position',[1,1,sizeBlock,sizeBlock])
%% Then the info
he=shift+sizeBlock+labelsiz;
wi=textBlock+1;
%valRange=round(min(barInput(:)):max(barInput(:)));
%c=colormap(jet(numel(valRange)))
augmL=121;%we don't want the darker values
cut=0.12;%proportion of the colorbar we want to cut out
c=colormap(jet(augmL));%from 0 to 100
c=c(round(cut*augmL):augmL,:);
for i=1:nmGr
    for j=1:nmAt+1
        if j<=nmAt
        r=rectangle('Position',[wi,he,sizeBlock,sizeBlock]);
        r.FaceColor=c(round(modesB(i,j)+1),:);
        curp=r.Position;
        indMode(i,j);
        tx=sprintf('%0.4s.\n %0.1f',Labels{j}{indMode(i,j)},modesB(i,j));
        text(curp(1)+lbshiftR,round(curp(2)+sizeBlock/2),tx,...
            'FontSize',fontSz-3,'Interpreter','none');
        wi=wi+sizeBlock;
        else
        r=rectangle('Position',[wi,he,sizeBlock,sizeBlock]);
        curp=r.Position;
        tx=sprintf('%0.1f',100*(sgR(i,2)-sgR(i,1)+1)/(1.0*size(Data,1)));
        text(curp(1)+lbshiftR,round(curp(2)+sizeBlock/2),tx,...
            'FontSize',fontSz-3,'Interpreter','none');
        wi=wi+sizeBlock;
        end
    end
    wi=textBlock+1;
    he=he+sizeBlock;
end
colorbar('Ticks',[0,1],...
         'TickLabels',{'0%','100%'})

end
