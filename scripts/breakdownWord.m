function [raw_word, function_type, movement_type, is_unfinished_sign]...
    = breakdownWord( word, function_type, movement_type, is_unfinished_sign )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
     
    if size(regexp(word, '\(UNKNOWN\)','match'),1) > 0
        raw_word = '';
        return;
    end
    
    raw_word = word;

    raw_word = strrep(raw_word, '?', '');

    if size(regexp(word, '\(FALSE-START\)','match'),1) > 0
        is_unfinished_sign = 1;
        raw_word = strrep(raw_word, '(FALSE-START)', '');
    else
        is_unfinished_sign = 0;
    end
    
    if size(regexp(word, '^DSEW','match'),1) > 0
        function_type = 'DSEW';
    elseif size(regexp(word, '^DSEP','match'),1) > 0
        function_type = 'DSEP';
    elseif size(regexp(word, '^DSH','match'),1) > 0
        function_type = 'DSH';
    elseif size(regexp(word, '^DSS','match'),1) > 0
        function_type = 'DSS';
    else
        function_type = '';
    end
    
    if size(regexp(word, 'MOVE:','match'),1) > 0
        movement_type = 'MOVE';
    elseif size(regexp(word, 'PIVOT:','match'),1) > 0
        movement_type = 'PIVOT';
    elseif size(regexp(word, 'AT:','match'),1) > 0
        movement_type = 'AT';
    elseif size(regexp(word, 'BE:','match'),1) > 0
        movement_type = 'BE';
    else
        movement_type = '';
    end
    
    raw_word = strrep(raw_word, 'ADD-TO-SIGNBANK(SERIES)', '');
    raw_word = strrep(raw_word, 'ADD-TO-SIGNBANK', '');
    raw_word = strrep(raw_word, 'ADD TO SIGNBANK', '');
    raw_word = strrep(raw_word, 'ADD-TO-SIGBANK', '');
    raw_word = strrep(raw_word, 'ADD-TO- SIGNBANK', '');
    
    if ~strcmp(movement_type,'')
        temp = strsplit(raw_word, sprintf('%s:',movement_type));
        raw_word = temp{2};
    else
        if ~strcmp(function_type,'')
            temp = regexp(raw_word,')-*','match');
            temp = strsplit(raw_word, temp{1});
            raw_word = temp{2};
        end
    end
    
    raw_word = strrep(raw_word, '(', '');
    raw_word = strrep(raw_word, ')', '');
    
    if size(regexp(word, 'PT:','match'),1) > 0
        temp = regexp(raw_word, '^[A-Z][A-Z,:, ,-,0-9]*', 'match');
    else
        temp = regexp(raw_word, '^[A-Z][A-Z,:, ,-]*', 'match');
    end
    

    if size(temp, 1) > 0
        raw_word = temp{1};
    end
    
    

end

