function [ mat ] = label2mat( label )
if size(label,1) > 1
    label = label';
end
mat = (repmat(label,numel(label),1)==repmat(label',1,numel(label)));
end

