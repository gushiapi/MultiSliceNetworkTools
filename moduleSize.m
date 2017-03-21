function moduleSize = moduleSize(S, c)
%% parameter and output
%          size: size of community c in S_pxT
%             S: overall community structure
%             c: index of the community of interest
tS = S;
tS(tS~=c) = 0;
tS(tS~=0) = 1;
existIdx = find(any(tS));
moduleSize = 0;
for i = existIdx
    moduleSize = moduleSize + sum(tS(:,i));
end
moduleSize = moduleSize/numel(existIdx);