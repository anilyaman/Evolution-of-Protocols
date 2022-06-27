function agent = mutate(agent, mr)
inx = find(rand(1, length(agent.genotype)) < mr);
for i=1:length(inx)
    action = agent.genotype(inx(i));
    if(action == 1)
        if(rand<0.5)
            agent.genotype(inx(i)) = 0;
        else
            agent.genotype(inx(i)) = 2;
        end
    elseif(action == 2)
        if(rand<0.5)
            agent.genotype(inx(i)) = 0;
        else
            agent.genotype(inx(i)) = 1;
        end
    else
        if(rand<0.5)
            agent.genotype(inx(i)) = 1;
        else
            agent.genotype(inx(i)) = 2;
        end
    end    
end

end