function res = delinear(X,y)
% regress out y from each column of X
res = X;
N = size(X,1);
for i = 1:size(X,2)
    b = regress(X(:,i),[ones(N,1), y]);
    Xhat = y * b(2:end);
    res(:,i) =  res(:,i) - Xhat;
end
end