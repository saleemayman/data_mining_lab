%SAME AS DATA EXTRACTOR, BUT NOT CELLS AS AN OUTPUT FOR SPEED & SWAG
%DATA BECOMES A MATRIX
%Conversion: num=cast(attribute,'uint8')/attribute=char(num);

%Script for the extraction of the data from the agaricus-lepiota.txt file, the output
%Data being a cell structure.
fid = fopen('agaricus-lepiota.txt');
C = textscan(fid,'%s'); % Read data skipping header
fclose(fid);
numAttr=23;
Data=zeros(numel(C{:}),numAttr);
for i=1:numel(C{:})
interm=strjoin(strsplit(C{:}{i},','),'');
Data(i,:)=cast(interm,'uint8');
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
AttributesTypes{index}='cap_shape';
Attributes{index}={'b','c','x','f','k','s'};
Labels{index}={'bell','conical','convex','flat','knobbed','sunken'};

index=3;
AttributesTypes{index}='cap_surface';
Attributes{index}={'f','g','y','s'};
Labels{index}={'fibrous','grooves','scaly','smooth'};

index=4;
AttributesTypes{index}='cap_color';
Attributes{index}={'n','b','c','g','r','p','u','e','w','y'};
Labels{index}={'brown','buff','cinnamon','gray','green','pink','purple','red','white','yellow'};

index=5;
AttributesTypes{index}='presence_of_bruises';
Attributes{index}={'t','f'};
Labels{index}={'bruises','no'};

%% 6-11

index = 6;
AttributesTypes{index} = 'odor';
Attributes{index} = {'a', 'l', 'c', 'y', 'f', 'm', 'n', 'p', 's'};
Labels{index} = {'almond', 'anise', 'creosote', 'fishy', 'foul', 'musty', 'none', 'pungent', 'spicy'};

index = 7;
AttributesTypes{index} = 'gill_attachment';
Attributes{index} = {'a', 'd', 'f', 'n'};
Labels{index} = {'attached', 'descending', 'free', 'notched'};

index = 8;
AttributesTypes{index} = 'gill_spacing';
Attributes{index} = {'c', 'w', 'd'};
Labels{index} = {'close', 'crowded', 'distant'};

index = 9;
AttributesTypes{index} = 'gill_size';
Attributes{index} = {'b', 'n'};
Labels{index} = {'broad', 'narrow'};

index = 10;
AttributesTypes{index} = 'gill_color';
Attributes{index} = {'k', 'n', 'b', 'h', 'g', 'r', 'o', 'p', 'u', 'e', 'w', 'y'};
Labels{index} = {'black', 'brown', 'buff', 'chocolate', 'gray', 'green', 'orange', 'pink', 'purple', 'red', 'white', 'yellow'};

index = 11;
AttributesTypes{index} = 'stalk_shape';
Attributes{index} = {'e', 't'};
Labels{index} = {'enlarging', 'tapering'};

%% 12-17
index = 12;
AttributesTypes{index} = 'stalk_root';
Attributes{index} = {'b', 'c', 'u', 'e', 'z', 'r', 'Q'};
Labels{index} = {'bulbous', 'club', 'cup', 'equal', 'rhizomorphs', 'rooted', 'missing'};

index = 13;
AttributesTypes{index} = 'stalk_surface_above_ring';
Attributes{index} = {'f', 'y', 'k', 's'};
Labels{index} = {'fibrous','scaly','silky','smooth'};

index = 14;
AttributesTypes{index} = 'stalk_surface_below_ring';
Attributes{index} = {'f', 'y', 'k', 's'};
Labels{index} = {'fibrous','scaly','silky','smooth'};

index = 15;
AttributesTypes{index} = 'stalk_color_above_ring';
Attributes{index} = {'n', 'b', 'c', 'g', 'o', 'p', 'e', 'w', 'y'};
Labels{index} = {'brown', 'buff', 'cinnamon', 'gray', 'orange', 'pink', 'red', 'white', 'yellow'};

index = 16;
AttributesTypes{index} = 'stalk_color_below_ring';
Attributes{index} = {'n', 'b', 'c', 'g', 'o', 'p', 'e', 'w', 'y'};
Labels{index} = {'brown', 'buff', 'cinnamon', 'gray', 'orange', 'pink', 'red', 'white', 'yellow'};

index = 17;
AttributesTypes{index} = 'veil_type';
Attributes{index} = {'p', 'u'};
Labels{index} = {'partial', 'universal'};

%% 18-23
index=18;
AttributesTypes{index}='veil_color';
Attributes{index}={'n','o','w','y'};
Labels{index}={'brown','orange','white','yellow'};

index=19;
AttributesTypes{index}='ring_number';
Attributes{index}={'n','o','t'};
Labels{index}={'none','one','two'};

index=20;
AttributesTypes{index}='ring_type';
Attributes{index}={'c','e','f','l','n','p','s','z'};
Labels{index}={'cobwebby','evanescent','flaring','large','none','pendant','sheathing','zone'};

index=21;
AttributesTypes{index}='spore_print_color';
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