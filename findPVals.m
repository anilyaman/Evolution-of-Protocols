% load('DEE9.mat')
[inxSolutionFound, medianSolutionFound, usedSlots, medianUsedSlots] = processResults(results);
[a,b] = min(medianUsedSlots');
r=[];
for i=1:length(b)
r(:,i) = usedSlots{i,b(i)}';
end
median(r)

% [p,h] = ranksum(r(:,2),r(:,3))