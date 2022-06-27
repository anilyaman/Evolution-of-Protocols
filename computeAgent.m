function agent = computeAgent(agent, k, x, y, settings)


agent.v = settings.images{k}(x,y,1);
agent.vp = agent.parameters(k);
agent.loss = agent.loss + abs(agent.v - agent.vp);

end