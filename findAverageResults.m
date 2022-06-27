function aveResults = findAverageResults(results)

k = length(results{1,1}.totalLossTrend);


[m,n] = size(results);
aveResults = zeros(k,n);
counters = zeros(1,n);

for i=1:m
    for j=1:n
        if(~isempty(results{i,j}))
            aveResults(:,j) = aveResults(:,j) +  results{i,j}.totalLossTrend';
            counters(j) = counters(j) + 1; 
        end
    end
end

for j =1:n
    aveResults(:,j) = aveResults(:,j)./counters(j);
end
