clear all;
load 'd:/fImages.mat';
readSafeFiles;
global bestNet;
load c:\randomSeed.mat;
rng(randomSeed);

trIdx=cell(1,3);
vlIdx=cell(1,3);
for p=1:3
    [trIdx{p},vlIdx{p}] = crossValidation(p);
end

trainSize=size(trIdx{1},2)+size(trIdx{2},2)+size(trIdx{3},2);
trainSet=zeros(trainSize,16*38);
valSize=size(vlIdx{1},2)+size(vlIdx{2},2)+size(vlIdx{3},2);
valSet=zeros(valSize,16*38);
t=0;
v=0;
targets=[];
labels=[];
for p=1:3
    for i=1:size(trIdx{p},2)
        t=t+1;
        trainSet(t,:)=fImages{p}.(['tr' safeFiles{p}.all.image{trIdx{p}(i)}(1:end-4)])(:);
    end
    for i=1:size(vlIdx{p},2)
        v=v+1;
        valSet(v,:)=fImages{p}.(['tr' safeFiles{p}.all.image{vlIdx{p}(i)}(1:end-4)])(:);
    end
    targets = [targets; safeFiles{p}.all.class(trIdx{p})];
    labels =  [labels; safeFiles{p}.all.class(vlIdx{p})];
end

[nets,err]=geneticTrainNetsAUCMSE(trainSet,targets,9000,100,9,3,valSet,labels);



est=netOutput(nets{1},valSet);
[x,y,t,auc]=perfcurve(labels,est,1);
auc
