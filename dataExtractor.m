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
%Creation of an attribute cell, listing all possible attributes and
%their values, plus their labels
Labels=cell(23,1);
Attributes=cell(23,1);
AttributesTypes=cell(23,1);

%TODO: just go to agaricus-lepiota.names (dataset description file) and
%fill in the different values accordingly

%% 1-5
index=1;
AttributesTypes{index}='class';
Attributes{index}={'e','p'};
Labels{index}={'edible','poisonous'};

index=2;
AttributesTypes{index}='cap-shape';
Attributes{index}={'b','c','x','f','k','s'};
Labels{index}={'bell','conical','convex','flat','knobbed','sunken'};

index=3;
AttributesTypes{index}='cap-surface';
Attributes{index}={'f','g','y','s'};
Labels{index}={'fibrous','grooves','scaly','smooth'};

index=4;
AttributesTypes{index}='cap-color';
Attributes{index}={'n','b','c','g','r','p','u','e','w','y'};
Labels{index}={'brown','buff','cinnamon','gray','green','pink','purple','red','white','yellow'};

index=5;
AttributesTypes{index}='presence-of-bruises';
Attributes{index}={'t','f'};
Labels{index}={'bruises','no'};

%% 6-11

%% 12-17
index = 12;
AttributesTypes{index} = 'stalk-root';
Attributes{index} = {'b', 'c', 'u', 'e', 'z', 'r', 'Q'};
Labels{index} = {'bulbous', 'club', 'cup', 'equal', 'rhizomorphs', 'rooted', 'missing'};

index = 13;
AttributesTypes{index} = 'stalk-surface-above-ring';
Attributes{index} = {'f', 'y', 'k', 's'};
Labels{index} = {'fibrous','scaly','silky','smooth'};

index = 14;
AttributesTypes{index} = 'stalk-surface-below-ring';
Attributes{index} = {'f', 'y', 'k', 's'};
Labels{index} = {'fibrous','scaly','silky','smooth'};

index = 15;
AttributesTypes{index} = 'stalk-color-above-ring';
Attributes{index} = {'n', 'b', 'c', 'g', 'o', 'p', 'e', 'w', 'y'};
Labels{index} = {'brown', 'buff', 'cinnamon', 'gray', 'orange', 'pink', 'red', 'white', 'yellow'};

index = 16;
AttributesTypes{index} = 'stalk-color-below-ring';
Attributes{index} = {'n', 'b', 'c', 'g', 'o', 'p', 'e', 'w', 'y'};
Labels{index} = {'brown', 'buff', 'cinnamon', 'gray', 'orange', 'pink', 'red', 'white', 'yellow'};

index = 17;
AttributesTypes{index} = 'veil-type';
Attributes{index} = {'p', 'u'};
Labels{index} = {'partial', 'universal'};

%% 18-23
index=18;
AttributesTypes{index}='veil-color';
Attributes{index}={'n','o','w','y'};
Labels{index}={'brown','orange','white','yellow'};

index=19;
AttributesTypes{index}='ring-number';
Attributes{index}={'n','o','t'};
Labels{index}={'none','one','two'};

index=20;
AttributesTypes{index}='ring-type';
Attributes{index}={'c','e','f','l','n','p','s','z'};
Labels{index}={'cobwebby','evanescent','flaring','large','none','pendant','sheathing','zone'};

index=21;
AttributesTypes{index}='spore-print-color';
Attributes{index}={'k','n','b','h','r','o','u','w','y'};
Labels{index}={'black','brown','buff','chocolate','green','orange','purple','white','yellow'};

index=22;
AttributesTypes{index}='population';
Attributes{index}={'a','c','n','s','v','y'};
Labels{index}={'abundant','clustered','numerous','scattered','several','solitary'};

index=23;
AttributesTypes{index}='habitat';
Attributes{index}={'g','l','m','p','u','w','d'};
Labels{index}={'grasses','leaves','meadow','path','urban','waste','woods'};