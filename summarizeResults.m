function summary = summarizeResults(results)
receivePercentageDuration = [];
aveActivity = [];
aveLatency = [];
inxSolutionFound = [];
inxSolutionFoundUsedSlots = [];
for i=1:length(results)
    inx = results{i}.packageReceived == 1;
    foundInx = find(inx,1);
    if(isempty(foundInx))
        inxSolutionFound(i) = 1;
        inxSolutionFoundUsedSlots(i) = 1;
    else       
        inxSolutionFound(i) = foundInx/results{i}.settings.maxGeneration;
        inxSolutionFoundUsedSlots(i) = results{i}.aveActivationTrend(foundInx)/results{i}.settings.timeFrame;
    end
    receivePercentageDuration(i) = sum(inx)/length(inx);
    aveActivity(i) = median(results{i}.aveActivationTrend(inx)./results{i}.settings.timeFrame);
    aveLatency(i) = median(results{i}.aveLatencyTrend(inx));
end
inx = receivePercentageDuration>0;
summary.solvedPercentage = sum(inx)/length(results);
summary.aveReceivePercentageDuration = median(receivePercentageDuration(inx));
summary.aveActivity = median(aveActivity(inx));
summary.inxSolutionFoundMedian = median(inxSolutionFound);
summary.inxSolutionFound = inxSolutionFound;
summary.inxSolutionFoundUsedSlots = (inxSolutionFoundUsedSlots);
summary.inxSolutionFoundUsedSlotsMedian = median(inxSolutionFoundUsedSlots);
summary.score = (1-summary.inxSolutionFound)*(1 - summary.aveActivity);
summary.aveLatency = median(aveLatency(inx));
summary.summary = [summary.solvedPercentage summary.aveReceivePercentageDuration summary.aveActivity summary.aveLatency];
%{'SolvedPecent', 'AveReceivedDur', 'AceActivity', 'AveLatency'}
%[summary.solvedPercentage summary.aveReceivePercentageDuration summary.aveActivity summary.aveLatency]



