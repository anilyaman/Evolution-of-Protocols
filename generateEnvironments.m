for i=1:28
i
dist = -1;
while dist ==-1
initialAgents = initializeAgents(settings,1,1);
dist = findDist(initialAgents,1,2);
end

for j=1:length(initialAgents)
    dist = findDist(initialAgents,j,2);
    initialAgents{j}.dist = dist;
end

environments{i} = initialAgents;
end