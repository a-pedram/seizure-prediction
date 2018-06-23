clear all
readSafeFiles;
load 'd:/fImages.mat';
load 'd:/d1sFreq.mat'
load 'd:/d1sFreqLog.mat';
load 'd:/d1sFreqCorr.mat';
load 'd:/d1sFreqCorrTrans.mat';
load 'd:/d1sHist.mat';
load 'd:/d1sHist2.mat';


maxKN=60;
q=(1 ./(1:maxKN))';

testIndices = cell(3,1);
trainIndices= cell(3,1);

for p=1:3
    sz=size(safeFiles{p}.all,1);
    rn = randperm(sz);
    trainIndices{p}=cell(6,1);
    testIndices{p}=cell(6,1);
    for r=1:6
        pat = zeros(1,sz);
        pat(1,floor((r-1)*.15 *sz) +1:floor(r *.15 *sz))=1;
        testIndices{p}{r}=rn(boolean( pat));
        pat = 1- pat;
        trainIndices{p}{r} =rn(boolean( pat));
    end    
end


scoresVector = cell(3,1);
for p= 1:3
    ii=0;
    scoresVector{p}=zeros(size(safeFiles{p}.all,1),10);
for r=1:6 
    
     d1 = zeros(size(trainIndices{p}{r},2),2);
     d2 = zeros(size(trainIndices{p}{r},2),2);     
     d3 = zeros(size(trainIndices{p}{r},2),2);     
     d4 = zeros(size(trainIndices{p}{r},2),2);     
     d5 = zeros(size(trainIndices{p}{r},2),2);     
     d6 = zeros(size(trainIndices{p}{r},2),2);  
    for i=1:size(testIndices{p}{r},2)        
        d1=d1sFreq{p}{testIndices{p}{r}(i)}(trainIndices{p}{r},:);
        d2=d1sFreqCorr{p}{testIndices{p}{r}(i)}(trainIndices{p}{r},:);
        d3=d1sFreqLog{p}{testIndices{p}{r}(i)}(trainIndices{p}{r},:);
        d4=d1sFreqCorrTrans{p}{testIndices{p}{r}(i)}(trainIndices{p}{r},:);
        d5=d1sHist2{p}{testIndices{p}{r}(i)}(trainIndices{p}{r},:);    
        d6=d1sHist{p}{testIndices{p}{r}(i)}(trainIndices{p}{r},:);
        d1= sortrows(d1,2);
        d2= sortrows(d2,2);
        d3= sortrows(d3,2);
        d4= sortrows(d4,2);
        d5= sortrows(d5,2);
        d6= sortrows(d6,2);
        kn=55;
        ii=ii+1;
        scoresVector{p}(ii,1) =sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+1)).^2);
        scoresVector{p}(ii,2) =sum(d2(1:kn,1) .* (1./(d2(1:kn,2)-d2(1,2)+1)).^2) / sum((1./(d2(1:kn,2)-d2(1,2)+1)).^2);
        scoresVector{p}(ii,3) = sum(d2(1:kn,1) .* (1./(d2(1:kn,2)-d2(1,2)+1))) / sum((1./(d2(1:kn,2)-d2(1,2)+1)));
        scoresVector{p}(ii,4) = sum(d3(1:kn,1) .* (1./(d3(1:kn,2)-d3(1,2)+1)).^2) / sum((1./(d3(1:kn,2)-d3(1,2)+1)).^2);
        scoresVector{p}(ii,5) = sum(d4(1:kn,1) .* (1./(d4(1:kn,2)-d4(1,2)+1)).^2) / sum((1./(d4(1:kn,2)-d4(1,2)+1)).^2);
        scoresVector{p}(ii,6) = sum(d5(1:kn,1) .* (1./(d5(1:kn,2)-d5(1,2)+1)).^2) / sum((1./(d5(1:kn,2)-d5(1,2)+1)).^2);
        scoresVector{p}(ii,7) = sum(d6(1:kn,1) .* (1./(d6(1:kn,2)-d6(1,2)+1)).^2) / sum((1./(d6(1:kn,2)-d6(1,2)+1)).^2);
        scoresVector{p}(ii,10)=safeFiles{p}.all.class(testIndices{p}{r}(i));
        fprintf('r:%d, p:%d,i:%d\n',r,p,i);
    end
end
scoresVector{p}=scoresVector{p}(1:ii,:);
end
save d:\scoresVector.mat scoresVector