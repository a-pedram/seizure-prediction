load ./variables/avgHistImage.mat;
load ./variables/histImages.mat;
load ./variables/histImagesTest.mat;
readSafeFiles;
scores=cell(3,1);
kn= [58 58 58];
q=(1 ./(1:60))';
d1sCorrHistTest= cell(3,1);
for p=1:3
    fileNames =fieldnames(histImagesTest{p});
    testSize =size(fileNames,1);
    us1 =zeros(testSize,1);
    trainSize=size(safeFiles{p}.all.image,1);
    d1 = zeros(trainSize,2);

    for i=1:testSize
        imgTest =histImagesTest{p}.(fileNames{i});
        imgTest(imgTest==-Inf) =0;
        for j=1:trainSize
            img =histImages{p}.(['tr' safeFiles{p}.all.image{j}(1:end-4)]);
            img(img==-Inf) =0;
            ansT=safeFiles{p}.all.class(j);            
            d1(j,2) = sqrt(sum(sum((corr(imgTest)-corr(img)).^2)));
            d1(j,1) =ansT;
        end
        d1sCorrHistTest{p}{i} =  d1;
        d1= sortrows(d1,2);              
        us1(i) = sum(d1(1:kn(p),1) .* q(1:kn(p)).^2) / sum(q(1:kn(p)).^2);
                
        fprintf('p:%d %d of %d\n',p,i,testSize);
    end
    
    scores{p} =us1;
end
save d:/d1sCorrHistTest.mat d1sCorrHistTest;

for p=1:3
    scores{p}=scores{p}(:,end);
end

sb = scores;

scores{p}=sb{p} * 1;
scores{p}=sb{p} * .9;
scores{p}=sb{p} * .8;

% sara 12csv fid= fopen('d:\imgCorrHistSara.csv','w');
fid= fopen('d:\imgCorrHistSara.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    fileNames =fieldnames(histImagesTest{p});
    testSize =size(fileNames,1);
    for i=1:testSize
        fprintf(fid,'%s,%g\n',[fileNames{i}(3:end) '.mat'],scores{p}(i));
    end
end
fclose(fid);