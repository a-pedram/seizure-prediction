function [clusters,nums] = clusterKmeans(data,numOfClusters)
[idx , clusters]= kmeans(data,numOfClusters);
nums=zeros(1,numOfClusters);
for i=1:size(idx,1)
    nums(idx(i))= nums(idx(i))+1;
end
end
