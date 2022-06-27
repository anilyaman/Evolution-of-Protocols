function agents = initializeChangedAgents(agents,stngs,target)

%locations = [0,0; 1,0; 2,0];
%locations = [0,0; 0,1; 0,2; 1,0; 1,1; 1,2; 2,0; 2,1; 2,2];

visualize = 0;
positions = zeros(length(agents),2);
%figure; 
clf; hold on;
for i = 1:length(agents)
    positions(i,:) = agents{i}.location;
    agents{i}.connections = [];
    agents{i}.dist = findDist(agents, i, target);
    for j=1:length(agents)
        if(i==j), continue; end
        dist = pdist2(agents{i}.location, agents{j}.location,'euclidean');
        if(dist < stngs.connectionDist && rand < stngs.connProb)
            agents{i}.connections(end+1) = j;
            if(visualize)
                plot([agents{i}.location(1),agents{j}.location(1)], ...
                    [agents{i}.location(2),agents{j}.location(2)], 'k');
            end
            
        end
    end
end
if(visualize)
    scatter(positions(:,1), positions(:,2),'k');
    drawnow
end









end