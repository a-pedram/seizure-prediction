clear all;
load 'd:/fImages.mat';
readSafeFiles;

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


load 'c:/users/mehdi/desktop/bestALLNet/bestNetALLpop100G1453S8287.mat'
b8287 = bestNet;
load 'c:/users/mehdi/desktop/bestALLNet/bestNetALLpop300G1000S8434.mat'
b8434 = bestNet;
load 'c:/users/mehdi/desktop/bestALLNet/bestNetALLpop300G845s8269.mat'
b8269 = bestNet;

est8287=netOutput(b8287,testSet);
est8434=netOutput(b8434,testSet);
est8269=netOutput(b8269,testSet);

stdEst8287= (est8287-min(est8287))/(max(est8287)-min(est8287));
stdEst8434= (est8434-min(est8434))/(max(est8434)-min(est8434));
stdEst8269= (est8269-min(est8269))/(max(est8269)-min(est8269));

figure;plot(est1,'marker','.','LineStyle','none');hold on;
plot(est2,'color','r','marker','.','LineStyle','none');hold on;
plot((est2+est1)/2,'color','g','marker','.','LineStyle','none');


finalEst