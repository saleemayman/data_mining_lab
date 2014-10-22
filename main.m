% Data description
clc
clearvars
close all
%data=readtable('agaricus-lepiota.txt','header',0);

fid = fopen('agaricus-lepiota.txt');
C = textscan(fid,'%s'); % Read data skipping header
fclose(fid);
Data=cell(size(C{:}));
for i=1:size(C{:},1)
Data{i}=strsplit(C{:}{i},',');
end
%%
Attribute23=cell(size(C{:},1),1);
counter=zeros(7,1);
for i=1:size(C{:},1)
    switch Data{i}{23}
        case 'g'
            counter(1)=counter(1)+1;
        case 'l'
            counter(2)=counter(2)+1;
        case 'm'
            counter(3)=counter(3)+1;
        case 'p'
            counter(4)=counter(4)+1;
        case 'u'
            counter(5)=counter(5)+1;
        case 'w'
            counter(6)=counter(6)+1;
        case 'd'
            counter(7)=counter(7)+1;
        otherwise
            disp('PROBLEM: WRONG CHAR')
    end
end
    %%
    counter5=zeros(9,1);
    for i=1:size(C{:},1)
        switch Data{i}{6}
            case 'a'
                counter5(1)=counter5(1)+1;
            case 'l'
                counter5(2)=counter5(2)+1;
            case 'c'
                counter5(3)=counter5(3)+1;
            case 'y'
                counter5(4)=counter5(4)+1;
            case 'f'
                counter5(5)=counter5(5)+1;
            case 'm'
                counter5(6)=counter5(6)+1;
            case 'n'
                counter5(7)=counter5(7)+1;
            case 'p'
                counter5(8)=counter5(8)+1;
            case 's'
                counter5(9)=counter5(9)+1;
            otherwise
                disp('PROBLEM: WRONG CHAR')
                i
        end
    end
