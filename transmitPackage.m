function agents = transmitPackage(agents, inx, timeSlot)

agent = agents{inx};

if(isempty(agents.queue))
    agent.fitness = agent.fitness - 1;
else
    connections = agent.connections;
    sent = 0;
    
    for c = 1:length(connections) %find all connected nodes
        actionConnection = agents{connections(c)}.genotype(timeSlot); %action of a connected node
        
        if(actionConnection == 2) %if it is listenning
            conn2 = agents{connections(c)}.connections; %find the connections of the connected node
            nonCollision = 1;
            for cc = 1:length(conn2) %check if there is a collision
                if(inx == conn2(cc)), continue; end
                if(agents{conn2(cc)}.genotype(timeSlot) == 1), nonCollision = 0; break; end
            end
            if(nonCollision)
                sent = 1;
                agents{connections(c)}.queue(end+1) = agents{inx}.queue(end);
                agents{connections(c)}.fitness = agents{connections(c)}.fitness + 1;
                if(connections(c) == settings.target)
                    numOfPackagesReceived = numOfPackagesReceived + 1;
                end
            end
        end
    end
    if(sent)
        agents{inx}.fitness = agents{inx}.fitness + 1;
        agents{inx}.queue(end) = [];
    else
        agents{inx}.fitness = agents{inx}.fitness - 1;
    end
end
            

end