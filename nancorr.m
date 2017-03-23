function [coef,pval ] =nancorr(x, varargin)
if nargin == 1
    x = x(~any(isnan(x),2),:);
    [coef,pval] = corr(x);
else
    if ~ischar(varargin{1})
        y =  varargin{1};
        vidx = ~any(isnan(x),2) & ~any(isnan(y),2);
        x = x(vidx,:);
        varargin{1} = y(vidx,:);
    end
    [coef,pval] = corr(x,varargin{:});
end

