function results = pipeline(settings)

results = cell(28,1);
parfor i=1:28
    rng(i*100);
    results{i} = DistributedEvo(settings, i*100);
end

