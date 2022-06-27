function [agents, receivedPercentage, aveLatency] = evaluate(agents,settings)

%ground truth may be how much the information is spreading through the
%network but nodes do not know that
receivedPackages = [];
for i=1:length(agents)     
    if(sum(agents{i}.genotype) == 0)
        agents{i}.fitness = -1000;
    else
        agents{i}.fitness = 0;
    end
    agents{i}.queue = [];
    agents{i}.packageHistory = [];
    agents{i}.stop = 0;
end

numOfPackagesSent = 0;
numOfPackagesReceived = 0;
for k = 1:settings.numOfSteps
    if(mod(k,settings.packageFrequency) == 1)
        numOfPackagesSent = numOfPackagesSent + 1;
        agents{settings.seed} = addPackage(agents{settings.seed}, [k k 0]);
    end
    
       
    
    timeSlot = mod(k-1,settings.timeFrame)+1;
    
    tempAgents = agents;
    for i=1:length(agents)
        action = agents{i}.genotype(timeSlot);
        if(action == 1) %trying to transmit
            if(isempty(agents{i}.queue))
                %################################################## RULE 1
                %if transmit but there is nothing in the queue
                agents{i}.fitness = agents{i}.fitness + settings.reinforcement(1); 
            else %trying to transmit and some packages in the queue
                conn = agents{i}.connections;
                sent = 0; packageID = 0;
                for c = 1:length(conn) %check all the connections for collisions and listening agents
                    if(agents{conn(c)}.genotype(timeSlot) == 2) %check for collisions with listening neighbors
                        conn2 = agents{conn(c)}.connections;
                        nonCollision = 1;
                        for cc = 1:length(conn2)
                            if(i == conn2(cc)), continue; end
                            if(agents{conn2(cc)}.genotype(timeSlot) == 1 && ... There is a neighbor with transit
                                    ~isempty(agents{conn2(cc)}.queue)) %%% Transmit attempt, actually there is somthing in the queue
                                nonCollision = 0; break; 
                            end
                        end
                        if(nonCollision) % No collisions
                            %################################ RULE 6 and 7
                            %if package received, increase the fitness
                            % the message was sent and acknowledged
                            %check if it was received before in target
                            copy = find(agents{conn(c)}.packageHistory == agents{i}.queue(end,1),1);
                            if(~isempty(copy)), continue; end
                            sent = 1;
                            if(agents{conn(c)}.stop)
                                tempAgents{i}.stop = 1;
                            elseif(agents{i}.stop)
                                tempAgents{conn(c)}.stop = 1;
                            end
                            tempAgents{conn(c)}.queue(end+1,:) = [agents{i}.queue(end,1) k i];
                            tempAgents{conn(c)}.packageHistory(end+1) = agents{i}.queue(end,1);
                            %increase the fitness of the receiver
                            agents{conn(c)}.fitness = agents{conn(c)}.fitness + settings.reinforcement(6);
                            if(conn(c) == settings.target)
                                receivedPackages = [receivedPackages;tempAgents{conn(c)}.queue(end,:) k-tempAgents{conn(c)}.queue(end,1)];
                                tempAgents{conn(c)}.queue(end,:) = [];
                                tempAgents{conn(c)}.stop = 1;
                            end
                        end
                    end
                end
                if(sent)
                    %####################################### RULE 2
                    %if package sent 
                    agents{i}.fitness = agents{i}.fitness + settings.reinforcement(2);
                    tempAgents{i}.queue(end,:) = [];
                else
                    %####################################### RULE 3
                    %if package not sent 
                    agents{i}.fitness = agents{i}.fitness + settings.reinforcement(3);
                end
            end
        elseif(action == 0)
            if(isempty(agents{i}.queue))
            %############### RULE 4
                 agents{i}.fitness = agents{i}.fitness + settings.reinforcement(4);
            elseif(~isempty(agents{i}.queue))
            %############### RULE 5
                agents{i}.fitness = agents{i}.fitness + settings.reinforcement(5);
            end
        end
    end
    
    for i=1:length(agents)
        agents{i}.queue = tempAgents{i}.queue;
        agents{i}.packageHistory = tempAgents{i}.packageHistory;
        agents{i}.stop = tempAgents{i}.stop;
        action = agents{i}.genotype(timeSlot);
        if(action == 2)
            %####################################### RULE 8
            %if Listen but not received
            if(isempty(agents{i}.queue))
                agents{i}.fitness = agents{i}.fitness + settings.reinforcement(8);
            elseif(agents{i}.queue(end,2) ~= k)
            %####################################### RULE 9
                agents{i}.fitness = agents{i}.fitness + settings.reinforcement(9);
            end    
        end
        
%         if(settings.visualize)
%             hold on;
%             if(isempty(agents{i}.queue))
%                 scatter(agents{i}.location(1,1), agents{i}.location(1,2),'b');
%             else
%                 scatter(agents{i}.location(1,1), agents{i}.location(1,2),'r');
%             end
%         end
%         
    end
end

numOfPackagesReceived = 0;
aveLatency = 0;
if(~isempty(receivedPackages))
    numOfPackagesReceived = length(unique(receivedPackages(:,1)));
    aveLatency = mean(receivedPackages(:,end));
end
receivedPercentage = numOfPackagesReceived/numOfPackagesSent;
if(receivedPercentage < 1)
    for i=1:length(agents)
        agents{i}.stop = 0;
    end
end




end


