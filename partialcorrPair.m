function [ partialCorrMatrix, partialPValMatrix] = partialcorrPair( X,Y,Z,varargin)

partialCorrMatrix = zeros(size(X,2),1);
partialPValMatrix = zeros(size(X,2),1);
for i = 1:size(X,2)
    if nargin == 4
        [partialCorrMatrix(i), partialPValMatrix(i)] = partialcorr(X(:,i), Y(:,i), Z,'type',varargin{1});
    else
        [partialCorrMatrix(i), partialPValMatrix(i)] = partialcorr(X(:,i), Y(:,i), Z);
    end
end

end

