%Script for the extraction of the data from the agaricus-lepiota.txt file, the output
%Data being a cell structure.
fid = fopen('agaricus-lepiota.txt');
C = textscan(fid,'%s'); % Read data skipping header
fclose(fid);
Data=cell(size(C{:}));
for i=1:size(C{:},1)
Data{i}=strsplit(C{:}{i},',');
end

%% Attributes
%also creation of an attribute cell, listing all possible attributes and
%their values, plus their labels
Labels=cell(23,1);
Attributes=cell(23,1);
AttributesType=cell(23,1);
index=1;
AttributesType{index}='class';
Attributes{index}={'e','p'};
Labels{index}={'edible','poisonous'};

%% 18-23
index=18;
AttributesType{index}='veil-color';
Attributes{index}={'n','o','w','y'};
Labels{index}={'brown','orange','white','yellow'};

index=19;
AttributesType{index}='ring-number';
Attributes{index}={'n','o','t'};
Labels{index}={'none','one','two'};

index=20;
AttributesType{index}='ring-type';
Attributes{index}={'c','e','f','l','n','p','s','z'};
Labels{index}={'cobwebby','evanescent','flaring','large','none','pendant','sheathing','zone'};

index=21;
AttributesType{index}='spore-print-color';
Attributes{index}={'k','n','b','h','r','o','u','w','y'};
Labels{index}={'black','brown','buff','chocolate','green','orange','purple','white','yellow'};

index=22;
AttributesType{index}='population';
Attributes{index}={'a','c','n','s','v','y'};
Labels{index}={'abundant','clustered','numerous','scattered','several','solitary'};

index=23;
AttributesType{index}='habitat';
Attributes{index}={'g','l','m','p','u','w','d'};
Labels{index}={'grasses','leaves','meadow','path','urban','waste','woods'};