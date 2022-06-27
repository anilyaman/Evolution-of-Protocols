function dist = findDist(agents, k, target)

if(target == k), dist = 0; return; end
dist = 1;
queue = {agents{k}.connections};
while ~isempty(queue)
    queue{end+1} = [];
    for i=1:length(queue{1})
        queue{end} = [queue{end} agents{queue{1}(i)}.connections];
    end
    queue{end} = unique(queue{end});
    dist = dist + 1;
    queue(1) = [];
    if(~isempty(find(queue{1} == target,1))),break; end
    if(dist > 100), dist = -1; break; end
end

end