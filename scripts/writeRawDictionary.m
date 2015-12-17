function [word, function_type, movement_type, is_unfinished_sign,...
    time_stamp1, time_stamp2, video_type, speaker_gender, listener_gender, file_name, folder_name]...
    = writeRawDictionary( Files, foldername, word, function_type, movement_type, is_unfinished_sign,...
    time_stamp1, time_stamp2, video_type, speaker_gender,...
    listener_gender, file_name, folder_name )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [~, participants] = strsplit(foldername, '[0-9]+','DelimiterType','RegularExpression');
    
    speakergen='';
    listenergen='';
    
    genderorder = strsplit(foldername, '_','DelimiterType','RegularExpression');
    genderorder = {genderorder{2}(1), genderorder{2}(2)};
        
    [~, vt] = strsplit(foldername, '[a-z]_', 'DelimiterType','RegularExpression');
    
    for i=1:size(Files, 1)
        if Files(i).bytes > 4096
            
            
            [~, speakernum] = strsplit(Files(i).name, '[0-9]+', 'DelimiterType','RegularExpression');
            xx = strfind(participants, speakernum{1});
            if(xx{1} == 1)
                speakergen = genderorder(1);
                listenergen = genderorder(2);
            else
                speakergen = genderorder(2);
                listenergen = genderorder(1);
            end
            
            xmlFile = xmlread(Files(i).name);
            annotationNodes = xmlFile.getElementsByTagName('ALIGNABLE_ANNOTATION');
            
            for k=0:annotationNodes.getLength - 1
                ts1 = annotationNodes.item(k).getAttribute('TIME_SLOT_REF1');
                ts1 = str2double(regexprep(char(ts1), '\D', ''));
                
                ts2 = annotationNodes.item(k).getAttribute('TIME_SLOT_REF2');
                ts2 = str2double(regexprep(char(ts2), '\D', ''));
                
                ftype = '';
                mtype = '';
                isunf = 0;
                
                w = annotationNodes.item(k).getElementsByTagName('ANNOTATION_VALUE');
                w = char(w.item(0).getFirstChild.getData);
                
                [w,ftype,mtype,isunf] = breakdownWord(w,ftype,mtype,isunf);
                
                if ~strcmp(w, '')
                    word = insertElement(word, {w});
                    function_type = insertElement(function_type, {ftype});
                    movement_type = insertElement(movement_type, {mtype});
                    is_unfinished_sign = insertElement(is_unfinished_sign, {isunf});
                    time_stamp1 = insertElement(time_stamp1, {ts1});
                    time_stamp2 = insertElement(time_stamp2, {ts2});                
                    video_type = insertElement(video_type, {vt{1}(1)});
                    speaker_gender = insertElement(speaker_gender, speakergen);
                    listener_gender = insertElement(listener_gender, listenergen);
                    file_name = insertElement(file_name, {Files(i).name});
                    folder_name = insertElement(folder_name, {foldername});
                end
            end
        end
    
    end
    

end

