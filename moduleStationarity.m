function stationarity = moduleStationarity(S, c)
%% parameter and output
%  stationarity: stationarity of community c in S_pxT
%             S: overall community structure
%             c: index of the community of interest
tS = S;
tS(tS~=c) = 0;
tS(tS~=0) = 1;
existIdx = any(tS);
tMin = find(existIdx,1,'first');
tMax = find(existIdx,1,'last');
stationarity = 0;
if tMin == tMax
    stationarity = 0;
else
    for t = tMin:tMax-1
        stationarity = stationarity + sum(tS(:,t) & tS(:,t+1))/max(1,sum(tS(:,t) | tS(:,t+1)));
    end
    stationarity = stationarity/(tMax-tMin);
end
end