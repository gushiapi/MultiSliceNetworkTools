function [h,rval,pval] = plotLinearFitWithCorr(X,Y)
if size(X,2) > 1
    X = X';
end
if size(Y,2) > 1
    Y = Y';
end
vIdx = ~any(isnan(X),2) & ~any(isnan(Y),2);
X = X(vIdx); Y = Y(vIdx);
[rval,pval] = corr(X,Y);
h = scatter(X,Y);
xlim([min(X),max(X)]); ylim([min(Y), max(Y)]);
axis square;
xlabel(inputname(1));
ylabel(inputname(2));
g = lsline;
set(g,'color','r');
text(nanmean(X),0.6*max(Y)+0.4*min(Y),sprintf('r = %.3f\np = %1.3e',rval,pval),'FontSize',20);
end

