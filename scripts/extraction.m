folderNames = extractfield(dir('05-899_Project/corpus/'),'name')';

word = [];
video_type = [];
speaker_gender = [];
listener_gender = [];
file_name = [];
folder_name = [];

narrativeCategories = {'mm', 'ww', 'mwm', 'wmw'};
conversationCategories = {'mm', 'ww', 'mw'};

% filteredNames = arrayfun(@(x) (folderNames{x}),... 
%     (find(cell2mat(cellfun(@(x) (size(strfind(x,'mwm'),2) > 0), folderNames,'un',0)))),'un',0);
% Files = dir(fullfile('05-899_Project','corpus',filteredNames{1},'*.eaf'));

for i = 5:size(folderNames, 1)
    Files = dir(fullfile('05-899_Project','corpus',folderNames{i},'*.eaf'));
    
    [word, video_type, speaker_gender, listener_gender, file_name, folder_name]...
    = writeRawDictionary(Files, folderNames{i}, word, video_type, speaker_gender,...
    listener_gender, file_name, folder_name);
end

TT = table(word, video_type, speaker_gender, listener_gender, file_name, folder_name);
writetable(TT, 'dictionary.dat');