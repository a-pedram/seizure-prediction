clear all;
load 'd:/fImages.mat';
readSafeFiles;
global bestNet;

testSet=zeros(1908,16*38);
fileNames=cell(3,1);
t=0;
for p=1:3
    files = dir(['e:\kaggle\seizure\test_' num2str(p) '_new\']);
    numOfFiles= size(files,1)-2;    
    for i= 1: numOfFiles
        fileName =files(i+2).name(1:end-4);
        t=t+1;
        testSet(t,:)=fImages{p}.(['ts' fileName])(:);
    end    
end

trainSet=zeros(size(safeFiles{1}.all,1)+size(safeFiles{2}.all,1)+size(safeFiles{3}.all,1),16*38);
t=0;
v=0;
targets=[];
for p=1:3
    for i=1:size(safeFiles{p}.all,1)
        t=t+1;
        trainSet(t,:)=fImages{p}.(['tr' safeFiles{p}.all.image{i}(1:end-4)])(:);
    end
    targets = [targets; safeFiles{p}.all.class];    
end
'start'
[nets,err]=geneticTrainNetsAUCMSE(trainSet,targets,9000,100,9,3);

%est=netOutput(bestNet,testSet);
est=netOutput(nets{1},testSet);


