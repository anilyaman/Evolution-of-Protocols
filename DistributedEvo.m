function result = DistributedEvo(settings, rnd_seed)
tic;
rng(rnd_seed);

agentsBest = settings.initialAgents;

packageReceived = zeros(1,settings.maxGeneration);
aveFitnessTrend = zeros(1,settings.maxGeneration);
aveActivationTrend = zeros(1,settings.maxGeneration);
aveLatencyTrend = zeros(1,settings.maxGeneration);
agentFitnessTrends = zeros(settings.numOfAgents,settings.maxGeneration);
[agentsBest, receivedPercentage] = evaluate(agentsBest, settings);

packageReceived(1) =  receivedPercentage;
aveFitnessTrend(1) = 0;

aveActive = 0;
for i=1:settings.numOfAgents
    agentFitnessTrends(i,1) = agentsBest{i}.fitness;
    aveActive = aveActive + sum(agentsBest{i}.genotype > 0);
end
aveActivationTrend(1) = aveActive/settings.numOfAgents;

for iter=2:settings.maxGeneration
    
    agents = agentsBest;
    for k = 1:length(agents)
        if(~agents{k}.stop)
            agents{k} = mutate(agentsBest{k}, settings.mr);
        end
    end
    
    [agents, receivedPercentage] = evaluate(agents, settings);
    packageReceived(iter) =  receivedPercentage;
    fitness = zeros(1, settings.numOfAgents);
    genotypes = [];
    for k = 1:length(agents)
        if(agents{k}.fitness >= agentsBest{k}.fitness)
        	agentsBest{k} = agents{k};
        end
        fitness(k) = agentsBest{k}.fitness;
        genotypes(end+1,:) = agentsBest{k}.genotype;
    end
    [agentsBest, receivedPercentage, aveLatency] = evaluate(agentsBest, settings);
    aveActive = 0;
    stops = zeros(1,settings.numOfAgents);
    for i=1:settings.numOfAgents
        agentFitnessTrends(i,iter) = agentsBest{i}.fitness;
        aveActive = aveActive + sum(agentsBest{i}.genotype > 0);
        stops(i) = agentsBest{i}.stop;
    end
    aveActivationTrend(iter) = aveActive/settings.numOfAgents;
    aveLatencyTrend(iter) = aveLatency;
    
    
    
    packageReceived(iter) =  receivedPercentage;
    aveFitnessTrend(iter) = mean(fitness);
    
    if(receivedPercentage == 1)
        break;
    end
    
%     genotypes
%     [fitness;stops]
%     subplot(4,1,1);
%     plot(packageReceived(1:iter)); 
%     %axis([1 iter -0.1 2])
%     subplot(4,1,2);
%     plot(aveFitnessTrend(1:iter));   
%     subplot(4,1,3);
%     plot(aveActivationTrend(1:iter));  
%     subplot(4,1,4);
%     plot(aveLatencyTrend(1:iter));   
%     drawnow
%     %pause(0.01);
    
    
    
end      
result.settings = settings;
%result.agents = agentsBest;
result.packageReceived = packageReceived;
result.aveFitnessTrend = aveFitnessTrend;
%result.agentFitnessTrends = agentFitnessTrends;
result.aveActivationTrend = aveActivationTrend;
result.aveLatencyTrend = aveLatencyTrend;
result.rnd_seed = rnd_seed;
result.timeElapsed = toc;


   