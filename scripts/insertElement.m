function [list] = insertElement( list, element )
    list = [list(1:end), element];
end