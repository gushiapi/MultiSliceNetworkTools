function c_partition = genRobustCommunity(B, N)
% for consensus_comm_wei
% C is a pxn matrix of community assignments where p is the number of optimizations
% that have been performed. n is the number of nodes in the system. C gives the real partitions. 
n = size(B,1);
p = N;
partitions = zeros(p,n);
for i = 1:N
    partitions(i,:) = genlouvain(B,10000,0);
end
for i = 1:3
    partitions = consensus_comm_wei(partitions);
end
c_partition = round(mean(partitions));
end