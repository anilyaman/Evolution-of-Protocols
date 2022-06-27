[inxSolutionFound, medianSolutionFound, usedSlots, medianUsedSlots] = processResults(results);


points = [median(medianSolutionFound,2) median(medianUsedSlots,2)];

%figure1 = figure;

% Create axes
% axes1 = axes('Parent',figure1);
% hold(axes1,'on');
%
% scatter(points(:,1), points(:,2),'Marker','pentagram','LineWidth',1.5)
% xlim([0,1.1])
% ylim([0,1.1])



labels = {'CHC','CSA','R1', 'R2', 'R3','R4', 'R5', 'R6','R7'};
mutation = {'01','02','04', '08', '16','32', '64'};
offsetX =[0.01, 0.01,0.01, 0.01, 0.01,0.01, 0.01, 0.01,0.01];
offsetY =[0.01,0.01,0.01, 0.01, 0.01,0.01, 0.01, 0.01,0.01];
for i=1:9
    text(points(i,1)+offsetX(i), points(i,2)+offsetY(i), labels{i},'FontSize',12);
end



% ylabel('Slot Use');
% xlabel('Resource Use');
% %set(axes,'FontSize',15);
% hold(axes1,'off');
% % Set the remaining axes properties
% set(axes1,'FontSize',15);

%save points points





types = {'h','s','o','^','v','p','d','<','>'};
colors = {'r','g','b','y','m','k',[0.1, 0.6, 0.8],[0.9, 0.2, 0.4],[0.2, 0.4, 0.3]};
rankList = [];
for i=1:7
    data{i} = [medianSolutionFound(:,i) medianUsedSlots(:,i)];
    rankList = [rankList;data{i}];
end
% figure;

clf
hold on;
dataLabels = {};
for j=1:7
    for ii=1:9
        scatter(data{j}(ii,1), data{j}(ii,2),100, types{ii}, 'MarkerFaceColor', [(j-1)/6, 1-(j-1)/6, 1-(j-1)/6],'MarkerEdgeColor',[0 0 0], 'LineWidth',0.1);
    end
    for i=1:9
        %  text(data{j}(i,1)+offsetX(i), data{j}(i,2)+offsetY(i), strcat(labels{i},mutation{j}),'FontSize',12);
        dataLabels{i,j} = strcat(labels{i},mutation{j});
    end
end
rankLabels = {};
rankLabels={};
for j=1:7
    for i=1:9
        rankLabels{end+1} = dataLabels{i,j};
    end
end
rankLabels = rankLabels';
rankList(:,3:4) = zeros(size(rankList,1),2);

[sV, sInx] = sort(rankList(:,1),'ascend');
rankList(sInx,3) = 1:size(rankList,1);
[sV, sInx] = sort(rankList(:,2),'ascend');
rankList(sInx,4) = 1:size(rankList,1); 
rankList(:,5) = sum(rankList(:,3:4),2);
[sV, sInx] = sort(rankList(:,5),'ascend');
rankList = rankList(sInx,:);
rankLabels = rankLabels(sInx);

xlabel('Used Resources')
ylabel('Used Slots')

set(gca,'FontSize',20)

figure2 = figure;

% Create heatmap
heatmap(figure2,medianSolutionFound,'ColorbarVisible','off','FontSize',15,...
    'YDisplayLabels',labels,...
    'XDisplayLabels',{'0.01', '0.02', '0.04','0.08','0.16','0.32','0.64'},...
    'YLabel','RuleID',...
    'XLabel','Mutation Rate (%)');


figure3 = figure;

% Create heatmap
heatmap(figure3,medianUsedSlots,'ColorbarVisible','off','FontSize',15,...
    'YDisplayLabels',labels,...
    'XDisplayLabels',{'0.01', '0.02', '0.04','0.08','0.16','0.32','0.64'},...
    'YLabel','RuleID',...
    'XLabel','Mutation Rate (%)');

