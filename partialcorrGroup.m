function [ partialCorrMatrix, partialPValMatrix] = partialcorrGroup( X,Y,Z )

partialCorrMatrix = zeros(size(X,2), size(Y,2));
partialPValMatrix = zeros(size(X,2), size(Y,2));
for i = 1:size(X,2)
    for j = 1:size(Y,2)
        [partialCorrMatrix(i,j), partialPValMatrix(i,j)] = partialcorr(X(:,i), Y(:,j), Z);
    end
end

end

