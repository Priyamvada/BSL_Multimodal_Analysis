function [word, video_type, speaker_gender, listener_gender, file_name, folder_name]...
    = writeRawDictionary( Files, foldername, word, video_type, speaker_gender,...
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
            annotationValues = xmlFile.getElementsByTagName('ANNOTATION_VALUE');
            
            for k=1:annotationValues.getLength - 1
                temp = annotationValues.item(k).getFirstChild.getData;
                word = insertElement(word, temp(1));
                
                video_type = insertElement(video_type, {vt{1}(1)});
                speaker_gender = insertElement(speaker_gender, speakergen);
                listener_gender = insertElement(listener_gender, listenergen);
                file_name = insertElement(file_name, {Files(i).name});
                folder_name = insertElement(folder_name, {foldername});
            end
        end
    
    end
    

end

