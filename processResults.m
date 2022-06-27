function [inxSolutionFound, medianSolutionFound, usedSlots, medianUsedSlots] = processResults(results)

summary = cell(size(results));
medianSolutionFound = zeros(size(results));
inxSolutionFound = cell(1,1);
medianUsedSlots = zeros(size(results));
usedSlots = cell(1,1);

sct = [];

for i=1:size(results,1)
    for j=1:size(results,2)
        summary{i,j} = summarizeResults(results{i,j});
        medianSolutionFound(i,j) = summary{i,j}.inxSolutionFoundMedian;
        inxSolutionFound{i,j} = summary{i,j}.inxSolutionFound;
        usedSlots{i,j} = summary{i,j}.inxSolutionFoundUsedSlots;
        medianUsedSlots(i,j) = summary{i,j}.inxSolutionFoundUsedSlotsMedian;
%         sct = [sct;results{i,j}{1}.settings.mr results{i,j}{1}.settings.mp medianSolutionFound(i,j)]; 
    end
end
return;
% 
figure1 = figure;

% Create heatmap
heatmap(figure1,medianSolutionFound,'ColorbarVisible','off','FontSize',15,...
    'YDisplayLabels',{1,2,3,4,5,6,7,8,9,10,11},...
    'XDisplayLabels',{'0.01', '0.02', '0.04','0.08','0.16','0.32','0.64'},...
    'YLabel','RuleID',...
    'XLabel','Mutation Rate (%)');


figure2 = figure;

% Create heatmap
heatmap(figure2,medianUsedSlots,'ColorbarVisible','off','FontSize',15,...
    'YDisplayLabels',{1,2,3,4,5,6,7},...
    'XDisplayLabels',{'0.01', '0.02', '0.04','0.08','0.16','0.32','0.64'},...
    'YLabel','RuleID',...
    'XLabel','Mutation Rate (%)');