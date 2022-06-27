function agent = addPackage(agent,id)
%     if(isempty(agent.queue))
%         agent.queue(end+1) = id;
%     elseif(length(agent.queue)>10)
%         agent.fitness = agent.fitness - 1;
%     else
%         agent.queue(end+1) = id;
%     end
    agent.queue(end+1,:) = id;
end