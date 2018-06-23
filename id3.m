function tree= id3(chunkNumber, tree,usedFeatures,parentScore)
global numOfValsFeature;
global trainData;
global freePlace;
global e95 l10 uFea;

chunkSize=size(trainData{chunkNumber},1);
posPercent = sum(trainData{chunkNumber}(:,end)==1) / chunkSize;
tree.IsLeaf=false;
tree.result = posPercent;
tree.size = chunkSize;
if chunkSize < 5
    tree.result=parentScore;
    %(parentScore * 12 + posPercent * chunkSize )/(12+chunkSize);
end
if posPercent > 0.9 || posPercent < 0.005
    tree.IsLeaf=true;
    trainData{chunkNumber}=[];
    e95=e95+1;
    return;
end
if chunkSize < 3
    tree.IsLeaf=true;
    trainData{chunkNumber}=[];
    l10 = l10 +1;
    return;
end
if sum(usedFeatures)>12
    tree.IsLeaf=true;
    trainData{chunkNumber}=[];
     uFea= uFea +1;
    return;  
end


feature = ID3selectFeature(chunkNumber,usedFeatures);
usedFeatures(feature)=1;
tree.feature = feature;
noc = numOfValsFeature(feature);
childrenChunk = zeros(noc,1);

for i=1:noc
    trainData{freePlace} = ...
        trainData{chunkNumber}(trainData{chunkNumber}(:,feature)==i,:) ;
    childrenChunk(i)=freePlace;
    freePlace =freePlace +1;
end
trainData{chunkNumber}=[];
tree.children = cell(noc,1);
for i=1:noc
    tree.children{i}= id3(childrenChunk(i),tree.children{i},usedFeatures,posPercent);
end
end