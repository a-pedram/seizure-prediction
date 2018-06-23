readSafeFiles;
load d:/fImages.mat

oneImages = cell(3,1);

for p=1:3
%    [trainIndices, testIndices]=dividerand(size(safeFiles{p}.ones,1),.15,.85);
    oneImages{p} = zeros(size(safeFiles{p}.ones,1),38*16);    
    for i=1:size(safeFiles{p}.ones,1)
        img=fImages{p}.(['tr' safeFiles{p}.ones.image{i}(1:end-4) ]);        
        oneImages{p}(i,:)=img(:);        
    end   
end

numOfClusters=[10 20 15];
totalEst=cell(3,1);
totalEst{1}= zeros(216,1);
totalEst{2}= zeros(1002,1);
totalEst{3}= zeros(690,1);
fileNames=cell(3,1);
fileNames{1}=cell(216,1);
fileNames{2}=cell(1002,1);
fileNames{3}=cell(690,1);
for r=1:15

oneClusters =cell(3,1);
for p=1:3
    [oneClusters{p}, numOfMems] = clusterKmeans(oneImages{p},numOfClusters(p));
    %numOfMems
end
est=cell(3,1);
for p=1:3
    dist= zeros(numOfClusters(p),1);
    files = dir(['e:\kaggle\seizure\test_' num2str(p) '_new\']);
    numOfFiles =size(files,1)-2;
    est{p} =zeros(100,1);
    for i=1:numOfFiles        
        img = fImages{p}.(['ts' files(i+2).name(1:end-4)]);
        fileNames{p}{i}=files(i+2).name;
        img = img(:);        
        %img = img.^5;
        for j=1:numOfClusters(p)
            n1=norm(oneClusters{p}(j,:));
            n2 = norm(img);
            nn = n1 *n2;
            if nn > 10
                dist(j)=sum(oneClusters{p}(j,:) .* img')/ (norm(oneClusters{p}(j,:)) * norm(img));
            else
               dist(j)=999999;
            end
            %dist(j) = norm(oneClusters{p}(j,:)-img'); 
        end        
        est{p}(i)=(min(dist));
    end    

    %figure;plot(X,Y);
        totalEst{p} = totalEst{p} +est{p};
end
r
end

for p=1:3
    totalEst{p}=totalEst{p} /15;
end

fid = fopen('d:/clusterOneDistance.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},totalEst{p}(i));
    end
end
fclose(fid);
