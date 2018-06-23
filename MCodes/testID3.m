
global trainData;
global numOfValsFeature;
global freePlace;
global e95 e05 l10 uFea;

e95=0; e05=0; l10=0; uFea=0;

for p=1:3
    
numOfValsFeature=max(answers{p});
trainData=cell(1);
trainData{1}=answers{p};
freePlace=2;
%ID3selectFeature(1,zeros(49,1))
tree = struct();

uf=zeros(19,1);
tree =id3(1,tree,uf,0.5);

fFile = ['.\variables\id3treeP' num2str(p) '.mat'];
save( fFile, 'tree');
end