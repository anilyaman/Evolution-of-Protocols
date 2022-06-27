conns = [];dist = [];
for j=1:28
for i=1:length(environments{j})
conns(i,j) =  length(environments{j}{i}.connections);
end
dist(j) =  findDist(environments{j},1,2);
end