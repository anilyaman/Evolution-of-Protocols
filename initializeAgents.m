function agents = initializeAgents(stngs, visualize, randomInit)

%locations = [0,0; 1,0; 2,0];
%locations = [0,0; 0,1; 0,2; 1,0; 1,1; 1,2; 2,0; 2,1; 2,2];
n = (stngs.numOfAgents);
if(~randomInit)
    n = sqrt(stngs.numOfAgents);
    locations = [];
    for i=0:n-1
        for j=0:n-1
            locations = [locations;i,j;];
        end
    end
end
if(randomInit)
    locations = rand(n,2);
    locations(1,:) = [0,0];
    locations(2,:) = [1,1];
end
agents = cell(stngs.numOfAgents,1);
for i=1:stngs.numOfAgents
    %0: nothing, %1:Transmit, %2: Listen
    %agents{i}.genotype = randi([0,2],1,stngs.timeFrame);
    agents{i}.genotype = zeros(1,stngs.timeFrame);
    agents{i}.location = locations(i,:);
    agents{i}.fitness = 0; %agents{i}.numOfAcknowledgements = [];
    agents{i}.packageHistory = [];
    %agents{i}.loss = 0;
%     agents{i}.receivedGenotype = [];
%     agents{i}.receivedGenotypeFrom = [];
%     agents{i}.receivedGenotypeFromRepeated = [];
    agents{i}.queue = [];
end


positions = zeros(length(agents),2);
%figure; 
clf; hold on;
for i = 1:length(agents)
    positions(i,:) = agents{i}.location;
    agents{i}.connections = [];
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