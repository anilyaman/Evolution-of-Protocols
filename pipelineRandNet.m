function results = pipelineRandNet(settings)

results = cell(28,1);
parfor i=1:28
    rng(i*100);
    settings2 = settings;
    settings2.initialAgents = settings.initialAgents{i};
    results{i} = DistributedEvo(settings2, i*100);
end

