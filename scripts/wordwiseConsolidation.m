threshold = 5;
meanwordsdata = zeros(120,21);

for i=1:120
    worddata = readtable(sprintf('05-899_Project/BSL_Multimodal_Analysis/results/wordwise_aus/w%d.dat',i));
    subrecs = strcmp(worddata.speaker_gender, 'm') & strcmp(worddata.listener_gender, 'w');

    wd = [worddata(subrecs,1) worddata(subrecs,6:25)];
    medianAUS = zeros(1,20);
    meansegmentdata = zeros(2700,21);
   
    segmentcount = 0;
    beginindex = 1;
    for j=1:size(wd,1)
        if j ~= 1 && wd.time_stamp(j) - wd.time_stamp(j-1) >= threshold || j==size(wd,1)
            segmentcount = segmentcount+1;
            medianAUS = median(cell2mat(table2cell(wd(beginindex:j,2:21))),1);
            
            meansegmentdata(segmentcount,:) = [(j-beginindex+1) medianAUS];
            
            beginindex = j;
        end
    end
    
    meansegmentdata = meansegmentdata(1:segmentcount,:);
    meanwordsdata(i,:) = [mean(meansegmentdata(:,1),1) median(meansegmentdata(:,2:21),1)];
end

meanwordsdata(logical(sum(meanwordsdata~=meanwordsdata,2)),:)=[];

xx = num2cell(meanwordsdata);
AUS_summarytable = cell2table(xx, 'VariableNames', [{'duration'} wd.Properties.VariableNames(:,2:21)]);
writetable(AUS_summarytable, 'FrequencySortedAUSSummaryTable_mw.dat');