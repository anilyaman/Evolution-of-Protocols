function runForRand()

pool = parpool('local',28);

%           r1  r2  r3  r4   r5  r6  r7  r8    r9
rules =  [-1  +1  -1  0    -1  +1  +1   0     0;
          -1  +1  -1  0.5    -1  +1  +1   0     0;
          -1  +1  -1  1    -1  +1  +1   0     0;
          -1  +1  -1  0    -1  +1  +1  -0.5  -0.5;
          -1  +1  -1  0    -1  +1  +1  -1    -1;
          -1  +1  -1  0.5  -1  +1  +1  -0.5  -0.5;
          -1  +1  -1  1    -1  +1  +1  -1    -1];

      
settings.numOfAgents = 36;
settings.maxGeneration = 10000;
settings.timeFrame = settings.numOfAgents; %size of the frame as long as the number of nodes
settings.packageFrequency = settings.timeFrame;
settings.numOfPackages = 5;
settings.numOfSteps = settings.packageFrequency * settings.numOfPackages; %10ms each time step
settings.connectionDist = 1.1;
settings.connProb = 0.1;

%initialAgents = initializeAgents(settings,0);
settings.seed = 1;
settings.target = 2;%settings.numOfAgents;
%settings.initialAgents = initialAgents;
load('randNet36.mat')
settings.initialAgents = initialAgents;

mutationRate = [0.01 0.02 0.04 0.08 0.16 0.32 0.64];
results = cell(size(rules,1), length(mutationRate));
load('DEERand36fixedNet.mat');
for r = 4:4%size(rules,1)
    for mr = 4:length(mutationRate)
        settings.mr = mutationRate(mr);
        settings.reinforcement = rules(r,:);
        results{r,mr} = pipeline(settings);
        save DEERand36fixedNet results
    end
end


delete(pool);

end