clear all
readSafeFiles;
load ./variables/histImages.mat;
load ./variables/histImagesTest.mat;
load 'd:/fImages.mat'; %both test and train images

maxKN=60;
q=(1 ./(1:maxKN))';
d1sFreqTest=cell(3,1);
d1sFreqCorrTest=cell(3,1);
d1sFreqLogTest=cell(3,1);
d1sFreqCorrTransTest=cell(3,1);
d1sHist2Test=cell(3,1);
d1sHistTest=cell(3,1);

scoresVectorTest = cell(3,1);
for p= 1:3
    fileNames =fieldnames(histImagesTest{p});
    trainFileNames=fieldnames(histImages{p});
    testSize =size(fileNames,1);
    trainSize=size(safeFiles{p}.all.image,1);
    
    scoresVectorTest{p}=zeros(testSize,10);
    
     d1 = zeros(trainSize,2);
     d2 = zeros(trainSize,2);     
     d3 = zeros(trainSize,2);     
     d4 = zeros(trainSize,2);     
     d5 = zeros(trainSize,2);     
     d6 = zeros(trainSize,2);  
    for i=1:testSize
        histImgTest =histImagesTest{p}.(fileNames{i});
        histImgTest(histImgTest==-Inf) =0;
        frqImgTest =fImages{p}.(fileNames{i});
        for j=1:trainSize
            fImg =fImages{p}.(trainFileNames{j});
            hImg =histImages{p}.(trainFileNames{j});
            ansT=safeFiles{p}.all.class(j);            
            d1(j,2) =  sum(sum(abs(frqImgTest-fImg)));
            d1(j,1) =ansT;
            d2(j,2) = sum(sum(abs(corrcoef(frqImgTest)-corrcoef(fImg))));
            d2(j,1) =ansT;
            d3(j,2) = sum(sum(abs(log(frqImgTest)-log(fImg))));
            d3(j,1) =ansT; 
            d4(j,2) = sum(sum(abs(corrcoef(frqImgTest')-corrcoef(fImg'))));
            d4(j,1) =ansT;
            d5(j,2) = sum(sum((histImgTest-hImg).^2));
            d5(j,1) =ansT;
            d6(j,2) = sum(sum(abs(histImgTest-hImg)));
            d6(j,1) =ansT;
        end
        d1sFreqTest{p}{i}=d1;
        d1sFreqCorrTest{p}{i}=d2;
        d1sFreqLogTest{p}{i}=d3;
        d1sFreqCorrTransTest{p}{i}=d4;
        d1sHist2Test{p}{i}=d5;
        d1sHistTest{p}{i}=d6;
        d1= sortrows(d1,2);
        d2= sortrows(d2,2);
        d3= sortrows(d3,2);
        d4= sortrows(d4,2);
        d5= sortrows(d5,2);
        d6= sortrows(d6,2);
        kn=55;
        scoresVectorTest{p}(i,1) =sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+1)).^2);
        scoresVectorTest{p}(i,2) =sum(d2(1:kn,1) .* (1./(d2(1:kn,2)-d2(1,2)+1)).^2) / sum((1./(d2(1:kn,2)-d2(1,2)+1)).^2);
        scoresVectorTest{p}(i,3) = sum(d2(1:kn,1) .* (1./(d2(1:kn,2)-d2(1,2)+1))) / sum((1./(d2(1:kn,2)-d2(1,2)+1)));
        scoresVectorTest{p}(i,4) = sum(d3(1:kn,1) .* (1./(d3(1:kn,2)-d3(1,2)+1)).^2) / sum((1./(d3(1:kn,2)-d3(1,2)+1)).^2);
        scoresVectorTest{p}(i,5) = sum(d4(1:kn,1) .* (1./(d4(1:kn,2)-d4(1,2)+1)).^2) / sum((1./(d4(1:kn,2)-d4(1,2)+1)).^2);
        scoresVectorTest{p}(i,6) = sum(d5(1:kn,1) .* (1./(d5(1:kn,2)-d5(1,2)+1)).^2) / sum((1./(d5(1:kn,2)-d5(1,2)+1)).^2);
        scoresVectorTest{p}(i,7) = sum(d6(1:kn,1) .* (1./(d6(1:kn,2)-d6(1,2)+1)).^2) / sum((1./(d6(1:kn,2)-d6(1,2)+1)).^2);
        %scoresVectorTest{p}(i,10)=safeFiles{p}.all.class(testIndices{p}{r}(i));
        fprintf('p:%d,i:%d of %d\n',p,i,testSize);
    end
end
save d:\scoresVectorTest.mat scoresVectorTest

save d:\d1sFreqTest.mat d1sFreqTest
save d:\d1sFreqCorrTest.mat d1sFreqCorrTest
save d:\d1sFreqLogTest.mat d1sFreqLogTest
save d:\d1sFreqCorrTransTest.mat d1sFreqCorrTransTest
save d:\d1sHist2Test.mat d1sHist2Test
save d:\d1sHistTest.mat d1sHistTest