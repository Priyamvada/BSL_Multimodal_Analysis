datafiles = dir(fullfile('05-899_Project','BSL_Multimodal_Analysis','extractedPos','*.dat'));
for i=1:size(datafiles,1)
    T = readtable(datafiles(i).name);
    delrows = T.success == 0;
    T(delrows,:) = [];
    writetable(T, datafiles(i).name);
end