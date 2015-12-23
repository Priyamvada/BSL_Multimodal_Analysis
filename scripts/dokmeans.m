T = readtable('FrequencySortedAUSSummaryTable.dat');

meanwordsdata = cell2mat(table2cell(T));

[idx,C,sumd,D] = kmeans(meanwordsdata,6);

x1 = min(meanwordsdata(:,1)):0.01:max(meanwordsdata(:,1));
x2 = min(meanwordsdata(:,2)):0.01:max(meanwordsdata(:,2));
[x1G,x2G] = meshgrid(x1,x2);
XGrid = [x1G(:),x2G(:)]; % Defines a fine grid on the plot

% idx2Region = kmeans(XGrid,3,'MaxIter',1,'Start',C);...
    % Assigns each node in the grid to the closest centroid

figure;
% gscatter(XGrid(:,1),XGrid(:,2),idx,...
%     [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0],'..');
% hold on;
plot(meanwordsdata(:,1),meanwordsdata(:,10),'k*','MarkerSize',5);
title 'BSLCP m-w Data';
xlabel 'Word Duration (frames)';
ylabel 'AUS01';
legend('Region 1');
hold off;