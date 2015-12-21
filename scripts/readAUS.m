dictionary = readtable('dictionaryFiltered.dat');
filenames = unique(dictionary.file_name);

for i=1:size(filenames);
    xmlFile = xmlread(filenames{i});
    n_elants = xmlFile.getElementsByTagName('TIME_SLOT').getLength;
    
    filename = strsplit(filenames{i}, '.eaf');
    filename = filename{1};
    
    if ~exist(sprintf('%s_aus.txt',filename),'file')
        continue;
    end
    
    aus_table = readtable(sprintf('%s_aus.txt',filename));
    n_clmts = size(aus_table, 1);
    factor = n_clmts/n_elants;
    
    rows = strcmp(dictionary.file_name,filenames{i})==1;
    vars = {'word','time_stamp1','time_stamp2','function_type','movement_type', 'speaker_gender', 'listener_gender'};
    subtable = dictionary(rows, vars);
    subtable = sortrows(subtable, 'time_stamp1');
    
    word = [];
    time_stamp = [];
    
    j = 1;
    w='';
    
    for k=1:n_clmts
        
        if j <= size(subtable, 1) && subtable.time_stamp2(j) < (k/factor) + 1
            j=j+1;
        end
        
        if j <= size(subtable, 1) && subtable.time_stamp1(j) < (k/factor)+1 && subtable.time_stamp2(j) > (k/factor)+1
            w = char(subtable.word(j));
        else
            w = '';
        end
        
        word = insertElement(word, {w});
        time_stamp = insertElement(time_stamp, {k});
    end
    
    time_stamp = time_stamp';
    word = word';
    annotatedTable = table(time_stamp, word);
    writetable([annotatedTable aus_table], sprintf('%s_aus_annotated.dat', filename));
end