clear all;
load 'd:/fImages.mat';
readSafeFiles;
global bestNet;


p=2;
trainSize=size(safeFiles{p}.all.image,1);
for i=1:trainSize
    trainSet(i,:)=fImages{p}.(['tr' safeFiles{p}.all.image{i}(1:end-4)])(:);
end



est=cell(3,1);
fileNames=cell(3,1);
testSet=cell(3,1);
for p=3:3
    files = dir(['e:\kaggle\seizure\test_' num2str(p) '_new\']);
    numOfFiles= size(files,1)-2;
    testSet{p}=zeros(numOfFiles,38*16);
    for i= 1: numOfFiles
        fileName =files(i+2).name(1:end-4);
        testSet{p}(i,:)=fImages{p}.(['ts' fileName])(:);
    end
    
end

'start'

targets = safeFiles{p}.all.class;
[nets,err]=geneticTrainNetsAUCMSE(trainSet,targets,1400,300,3,2);



est3=netOutput(bestNet,testSet{p});