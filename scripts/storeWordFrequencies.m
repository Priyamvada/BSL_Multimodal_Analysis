destinationfilename = 'FrequencyTableSorted_wm.dat';
sourcefilename = 'dictionaryFiltered.dat';

sourcedictionary = readtable(sourcefilename);
subrecords = (strcmp(sourcedictionary.speaker_gender, 'w') & strcmp(sourcedictionary.listener_gender, 'm'));
sourcedictionary = sourcedictionary(subrecords,:);

%apply other filters if required

%getting words
words = sourcedictionary.word;
%speaker_gender = sourcedictionary.speaker_gender;
%listener_gender = sourcedictionary.listener_gender;

uniquewords = unique(words);
Repetitions=cellfun(@(w) sum(ismember(words,w)),uniquewords,'un',0);

FrequencyTable = table(uniquewords, Repetitions);
FrequencyTable = sortrows(FrequencyTable, 'Repetitions', 'descend');

writetable(FrequencyTable, destinationfilename);
