%clear all;
close all;
readSafeFiles;
load './variables/avgImages.mat'
load 'd:/fImages.mat';
est=cell(3,1);
fileNames=cell(3,1);
mask =cell(3,1);

mask{1} = mask1;
mask{2} = mask2;
mask{3} = mask3;
pow=[ 1 1 1];
q=[1 1 1];
for p=1:3
    files = dir(['e:\kaggle\seizure\test_' num2str(p) '_new\']);
    numOfFiles= size(files,1)-2;
    fileNames{p}=cell(numOfFiles,1);
    est{p} = zeros(numOfFiles,1);
    for i= 1: numOfFiles
         fileName =files(i+2).name(1:end-4);
%         d2zero = (sum(sum((avgImages{p}.train0 +avgImages{p}.dTestTrain - fImages{p}.(['ts' fileName])).^2)));
%         d2one  = (sum(sum((avgImages{p}.train1 +avgImages{p}.dTestTrain - fImages{p}.(['ts' fileName])).^2)));  
        %Cosine product  %    + .5* avgImages{p}.dTestTrain
        d2zero = (sum(sum((avgImages{p}.Importance .* mask{p} .* (avgImages{p}.train0 ) .* fImages{p}.(['ts' fileName])).^pow(p))));
        d2one  = (sum(sum((avgImages{p}.Importance .* mask{p} .* (avgImages{p}.train1 ) .* fImages{p}.(['ts' fileName])).^pow(p))));
        est{p}(i)=q(p)* d2one/d2zero;
        if isnan(est{p}(i))
            est{p}(i)=1;
        end
        fileNames{p}{i}=[fileName '.mat'];       
    end
    mean(est{p})
    m= mean(est{p});
    est{p}(est{p}==1)=m;
    est{p}= (est{p} - mean(est{p}))./std(est{p});
    
end
est{1}=(est{1}+6)*1.2;
est{2}=(est{2}+6);
est{3}=(est{3}+6)*.97;
fid= fopen('d:/freqImgCosGeneticMaskedNormalizedP1_2P1P_97.csv','w');
%fid= fopen('d:/4.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},est{p}(i));
    end
end
fclose(fid);
