%Clustering Tentative 2

%I didn't understand how to do clustering properly in Weka... I'll remedy
%% Clean ALL THE THINGS!
clc
clearvars
close all
disp('Workspace cleared and ready to go.');
%delete(gcp) that and the following line are for parr. comput.
%pool=parpool; 

%% Load the datas, labels and stuff
tic
run betterDataExtractor.m
t=toc;
fprintf('betterDataExtractor successful, t=%0.4f s.\n',t);
%% Alright. Now we see how we can transform our instances.

%the idea is to convert each instance in a binary word of the form
%(att1hasvalue1 att1hasvalue2 ... att1hasvaluen att2hasvalue1 ... att2hasvalue2 ... att2hasvaluen)
numAttr=23;
attribLength=zeros(numAttr,1);
for i=1:numAttr
   attribLength(i)=size(Attributes{i},2);
end
totBools=sum(attribLength);
fprintf('The total number of bools will be %i \n',sum(attribLength));
attribArray=zeros(1,totBools);%array of the ascii codes of all attributes in a 1x128 array
index=0;
for i=1:numAttr
   for j=1:size(Attributes{i},2);
       index=index+1;
       attribArray(index)=Attributes{i}{j};
   end
end
for i=1:numAttr
   attribLength(i)=size(Attributes{i},2);
end
%here we go
boolInstances=zeros(size(Data,1),totBools);%init of what we want
%now the slow part. Still try to to this column by column

tic
attribCumLength=cumsum(attribLength);
index=1;
for i=1:totBools
    if i>attribCumLength(index)
        index=index+1;
    end
    boolInstances(:,i)=(ones(size(Data,1),1)*(attribArray(i)))==Data(:,index);
end
toc
disp('Conversion to boolean Complete')
%% Getting rid of empty attributes and values
%for easy reference
hammingAttrVal=cell(128,1);
index=1;
for i=1:23
    for j=1:numel(Attributes{i})
        hammingAttrVal{index}=strcat(AttributesTypes{i},':',Attributes{i}{j});
        index=index+1;
    end
end


%Veil Type (17 A, Val 1,2)


%Ring type: cobwebby sheating zone (20 A, Val 1,7,8)
%Stalk Root: rhizomorphs, cup (12 A, Val 3,5)
%Gill spacing:distant (8 A, 3)
emptycol=zeros(128,1);
for i=1:128
    if (boolInstances(:,i)==0)
        emptycol(i)=1;
    end
end
emptyValAttr= find(emptycol>0);
for i=1:numel(emptyValAttr)
    disp(hammingAttrVal{emptyValAttr(i)})
end

%Also 90 is veil_type partial:to be removed
%Also 63 is missing values: to be removed
toBeRm=[emptyValAttr' 63 90];
toBeRm=sort(toBeRm, 'descend');
boolInstancesMod=boolInstances;
for i=1:numel(toBeRm)
boolInstancesMod=[boolInstancesMod(:,1:(toBeRm(i)-1)),...
                  boolInstancesMod(:,(toBeRm(i)+1):end)];
end
%BOOLINSTANCE: DATASET TO BINARY
%BOOLINSTANCEMOD: BINARY DATASET, FILTERED
