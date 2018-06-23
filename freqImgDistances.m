readSafeFiles;
load 'd:/fImages.mat';
est=cell(3,1);
scores=cell(3,1);
cols={'r','g','b'};
% mask{1} = mask1;
% mask{2} = mask2;
% mask{3} = mask3;
pow=[ 1 3 1.1];
nk= [25 34 45];
maxKN=60;
q=(1 ./(1:maxKN))';
d1sFreq= cell(3,1);
d1sFreqLog= cell(3,1);
d1sFreqCorr= cell(3,1);
d1sFreqCorrTrans=cell(3,1);
for p=1:3
     numOfFiles = size(safeFiles{p}.all,1);
     us1 =zeros(numOfFiles,60);
     d1 = zeros(numOfFiles,2);
     d2 = zeros(numOfFiles,2);
     d3 = zeros(numOfFiles,2);
     d4 = zeros(numOfFiles,2);
     d1sFreq{p}= cell(numOfFiles,1);
    est{p} = zeros(size(safeFiles{p}.all,1),1);
    for i=1:numOfFiles
        d1sFreq{p}{i}= zeros(numOfFiles,2);
        imgTest =fImages{p}.(['tr' safeFiles{p}.all.image{i}(1:end-4)]);
        for j=1:numOfFiles
            img =fImages{p}.(['tr' safeFiles{p}.all.image{j}(1:end-4)]);
            ansT=safeFiles{p}.all.class(j);
            d1(j,2) = sum(sum(abs(imgTest-img)));
            d1(j,1) =ansT;            
            d2(j,2) = sum(sum(abs(log(imgTest+.001)-log(img+.001))));
            d2(j,1) =ansT;
            d3(j,2) = sum(sum(abs(corrcoef(imgTest)-corrcoef(img))));
            d3(j,1) =ansT;
            d4(j,2) = sum(sum(abs(corrcoef(imgTest')-corrcoef(img'))));
            d4(j,1) =ansT;
        end        
        d1sFreq{p}{i}=d1;
        d1sFreqLog{p}{i}=d2;
        d1sFreqCorr{p}{i}=d3;
        d1sFreqCorrTrans{p}{i}=d4;
        fprintf('p:%d i:%d\n',p,i);
    end
    %figure;plot(X,Y)
end
save 'd:/d1sFreq.mat' d1sFreq;
save 'd:/d1sFreqLog.mat' d1sFreqLog;
save 'd:/d1sFreqCorr.mat' d1sFreqCorr;
save 'd:/d1sFreqCorrTrans.mat' d1sFreqCorrTrans;
sb = scores;
