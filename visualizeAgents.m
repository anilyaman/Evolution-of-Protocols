function visualizeAgents(agents)

positions = [];
for i=1:length(agents)
    positions = [positions; agents{i}.location];
end
%figure; 
clf; hold on;
for i = 1:length(agents)
    positions(i,:) = agents{i}.location;
    for j=1:length(agents)
        if(i==j), continue; end
        if(~isempty(find(agents{j}.connections == i)))
            plot([agents{i}.location(1),agents{j}.location(1)], ...
            	[agents{i}.location(2),agents{j}.location(2)], 'k');           
        end
    end
end
scatter(positions(:,1), positions(:,2),'k');
drawnow









end