
clear all;
load 'd:/fImages.mat';
readSafeFiles;
load c:\randomSeed.mat;
rng(randomSeed);
p=2;
[trIdx,vlIdx] = crossValidation(p);

trainSize=size(trIdx,2);
%trainSet=zeros(trainSize,16*38);
trainSet=zeros(5,16*16);
valSize=size(vlIdx,2);
%valSet=zeros(valSize,16*38);
valSet=zeros(5,16*16);
j=0
for i=1:trainSize    
    corFImg = corrcoef(fImages{p}.(['tr' safeFiles{p}.all.image{trIdx(i)}(1:end-4)]));
    if sum(sum(isnan(corFImg)))>0
        continue;
    end
    j=j+1;
    trainSet(j,:)=corFImg(:);
    targets(j,1) = safeFiles{p}.all.class(trIdx(i));
end
j=0;
for i=1:valSize    
    corFImg = corrcoef(fImages{p}.(['tr' safeFiles{p}.all.image{vlIdx(i)}(1:end-4)]));
    if sum(sum(isnan(corFImg)))>0
        continue;
    end
    j=j+1;
    valSet(j,:)=corFImg(:);
    labels(j,1)=safeFiles{p}.all.class(vlIdx(i));
end
%targets = safeFiles{p}.all.class(trIdx);
%labels=safeFiles{p}.all.class(vlIdx);
%p1
%[nets,err]=geneticTrainNetsAUCMSE(trainSet,targets,9000,100,4,2,valSet,labels);

%p2:
[nets,err]=geneticTrainNetsAUCMSE(trainSet,targets,9000,100,4,2,valSet,labels);


est=netOutput(nets{1},valSet);
[x,y,t,auc]=perfcurve(labels,est,1);
auc

