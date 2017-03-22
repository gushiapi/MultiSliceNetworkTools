function [modularity, nCommunity,meanCommuntiySize,stationarity,S] = multiSliceCommunityStats(A,gplus,gminus,omega,varargin)
%% parameters and Output:
%  A                 : cell array
%  Modularity        : the value of the modularity function
%  NCommunity        : the number of communities
%  meanCommuntiySize : the mean number of nodes per community over all time
%                      windows over which the community exists
%  Stationarity      : for a given module C, zeta_C is the average correlation 
%                      between subsequent states
%  S                 : corresponding community structure
%  varargin{1}       : function handle of random on A
%  varargin{2}       : type of B, can be 'ordered', 'randomSliceConnection',
%                      and 'randomSliceOrder'
%                      default is the 'ordered'
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% check whether it is randomized model
if nargin < 4 || nargin > 6
    error(['Input Error! Please input 4 params for default model and 6 '...
        'parameters for randomized or undefault model!']);
end
Iter = 50;
BType = 'orderedSlice';
if nargin > 4
    for i = 1:numel(A)
        A{i} = varargin{1}(A{i},Iter);
    end
    if nargin == 6
        BType = varargin{2};
    end
end

%% construct the B-modular function

[B,twomu,p,T] = multiSliceA2B(A, gplus, gminus,omega,BType);

%% compute the community structure
[S,modularity] = genlouvain(B);
modularity = modularity/twomu;
S = reshape(S,p,T);

%% compute the stats
uniqueLabel = unique(S);
nCommunity = numel(uniqueLabel);
meanCommuntiySizeVec = zeros(nCommunity,1);
stationarityVec = zeros(nCommunity,1);
for i = 1:nCommunity
    meanCommuntiySizeVec(i) = moduleSize(S,uniqueLabel(i));
    stationarityVec(i) = moduleStationarity(S,uniqueLabel(i));
end
meanCommuntiySize = nanmean(meanCommuntiySizeVec);
stationarity = nanmean(stationarityVec);

end