allwords = readtable('FrequencyTableSorted.dat');
datafiles = dir(fullfile('05-899_Project','BSL_Multimodal_Analysis','extractedAUS','*.dat'));
dictionaryFiltered = readtable('dictionaryFiltered.dat');

basetable = readtable(sprintf('05-899_Project/BSL_Multimodal_Analysis/extractedAUS/%s',datafiles(1).name));
temp = cell(size(basetable,1),1);
temp(:,:) = {''};
basetable = [basetable cell2table(temp,'VariableNames',{'speaker_gender'}) cell2table(temp,'VariableNames',{'listener_gender'})];

    for j = 1:120
        w = allwords.uniquewords{j};
        
        basetable(:,:) = [];

        for i = 1:size(datafiles,1)
            ausdata = readtable(sprintf('05-899_Project/BSL_Multimodal_Analysis/extractedAUS/%s',datafiles(i).name));
            splitfilename = strsplit(datafiles(i).name, '_aus_');
            matchingindices = find(strcmp(dictionaryFiltered.file_name, sprintf('%s.eaf',splitfilename{1})));
            spkr = dictionaryFiltered.speaker_gender(matchingindices(1));
            lstnr = dictionaryFiltered.listener_gender(matchingindices(1));
                    
            wmatches = strcmp(ausdata.word, w);
            woccurences = ausdata(wmatches,:);
            
            spkrs = cell(size(woccurences,1),1);
            spkrs(:,:) = spkr;
    
            lstnrs = cell(size(woccurences,1),1);
            lstnrs(:,:) = lstnr;
            
            woccurences = [woccurences cell2table(spkrs,'VariableNames',{'speaker_gender'}) cell2table(lstnrs,'VariableNames',{'listener_gender'})];

            basetable = [basetable; woccurences];
        end
        
        writetable(basetable, sprintf('w%d.dat',j));
    end
