

pClusterDistanc=[14 14 14];
clusters = cell(3,1);
for p=1:3
sa = size(pnAvgs{p},1);
nu = zeros(2000,1);
indices = randperm(sa);
nc=0;
for i=1:sa
    dMin=999999;
    for j= 1:nc
        d = sqrt(sum((pnAvgs{p}(indices(i),1:16) - clusters{p}(j,1:16)).^2));
        if d < dMin
            dMin =d;
            minC=j;            
        end        
    end
    if dMin>pClusterDistanc(p)
        nc=nc+1;
        clusters{p}(nc,:)=pnAvgs{p}(indices(i),1:17);
    else
        clusters{p}(minC,1:16)=(clusters{p}(minC,1:16) * nu(minC) + pnAvgs{p}(indices(i),1:16))/(nu(minC)+1);
        nu(minC)=nu(minC)+1;
    end
end
% delete sparse clusters
for j=nc:-1:1
    if nu(j)<2
        clusters{p}(j,:)=[];
        nc= nc-1;
    end
end
nu = zeros(2000,1);
clusters{p}(:,17)= zeros(nc,1);
for i=1:sa
    dMin=999999;
    for j= 1:nc
        d = sqrt(sum((pnAvgs{p}(i,1:16) - clusters{p}(j,1:16)).^2));
        if d < dMin
            dMin =d;
            minC=j;            
        end
    end
    clusters{p}(j,1:16)=(clusters{p}(minC,1:16) * nu(minC) + pnAvgs{p}(i,1:16))/(nu(minC)+1);
    clusters{p}(minC,17) =clusters{p}(minC,17) +pnAvgs{p}(i,17);
    nu(minC)=nu(minC)+1;
end
clusters{p}(:,17) =clusters{p}(:,17) ./ nu(1:nc);
end
save './variables/clustersAvg.mat' clusters;