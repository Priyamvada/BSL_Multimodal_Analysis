folderNames = extractfield(dir('05-899_Project/corpus/'),'name')';

word = [];
function_type = [];
movement_type = [];
is_unfinished_sign = [];
time_stamp1 = [];
time_stamp2 = [];
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
    
    [word, function_type, movement_type, is_unfinished_sign, ...
        time_stamp1, time_stamp2, video_type, speaker_gender, listener_gender,...
        file_name, folder_name]...
    = writeRawDictionary(Files, folderNames{i}, word,...
    function_type, movement_type, is_unfinished_sign,time_stamp1, time_stamp2,...
    video_type, speaker_gender,...
    listener_gender, file_name, folder_name);
end

word = word';
video_type = video_type';
speaker_gender = speaker_gender';
listener_gender = listener_gender';
file_name = file_name';
folder_name = folder_name';
function_type = function_type';
movement_type = movement_type';
is_unfinished_sign = is_unfinished_sign';
time_stamp1 = time_stamp1';
time_stamp2 = time_stamp2';

TT = table(word, function_type, movement_type, is_unfinished_sign,...
    time_stamp1, time_stamp2, video_type, speaker_gender, listener_gender,...
    file_name, folder_name);

writetable(TT, 'dictionaryFiltered.dat');