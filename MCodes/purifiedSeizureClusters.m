readSafeFiles;
load d:/fImages.mat
oneImages = cell(20,1);
dZeros = cell(3,1);

for p=1:3
    dZeros{p}= zeros(size(safeFiles{p}.ones,1),38*16);    
    for i=1:size(safeFiles{p}.ones,1)
        oneImages{i}=fImages{p}.(['tr' safeFiles{p}.ones.image{i}(1:end-4)]);        
        for j= 1:size(safeFiles{p}.zeros,1)
            zImg=fImages{p}.(['tr' safeFiles{p}.zeros.image{j}(1:end-4)]);
            d =(oneImages{i} - zImg);
            dZeros{p}(i,:) = dZeros{p}(i,:) + d(:)';
        end
        dZeros{p}(i,:)=(dZeros{p}(i,:)-mean(dZeros{p}(i,:)))/std(dZeros{p}(i,:));
        fprintf('p:%d %d of %d\n',p,i,size(safeFiles{p}.ones,1));
    end    
end
save ./variables/dZeros.mat dZeros

numOfClusters=[10 10 10];
seizureClusters =cell(3,1);
for p=1:3
    [seizureClusters{p}, numOfMems] = clusterKmeans(dZeros{p},numOfClusters(p));
    %numOfMems
    for i=1:numOfClusters(p)
        seizureClusters{p}(i,:)=seizureClusters{p}(i,:) ./ max([-min(seizureClusters{p}(i,:)) max(seizureClusters{p}(i,:))]);
    end
    %seizureClusters{p} = seizureClusters{p}.^3;
end

figure;
for p=1:3
    for i=1:numOfClusters(p)
        img = reshape(seizureClusters{p}(i,:),38,16);
        subplot(3,numOfClusters(p),(p-1)*numOfClusters(p)+i);
        imshow(img,[min(img(:)) max(img(:))]);
    end
end

for p=1:3
    cosineP= zeros(numOfClusters(p),1);
    numOfFiles =size(safeFiles{p}.all,1);
    labels = zeros(numOfFiles,1);
    est =zeros(numOfFiles,1);
    for i=1:numOfFiles
        labels(i) = safeFiles{p}.all.class(i);
        img = fImages{p}.(['tr' safeFiles{p}.all.image{i}(1:end-4)]);        
        img = img(:);
        img = (img - mean(img)) / std(img);
        %img = img.^5;
        for j=1:numOfClusters(p)
            cosineP(j) = sum(seizureClusters{p}(j,:) .* img') / (norm(seizureClusters{p}(j,:)) * norm(img));
        end
        est(i)=max(cosineP);
    end
    [X,Y,T,AUC] = perfcurve(labels,est,1);
    fprintf('%g\n',AUC);
    %figure;plot(X,Y);
end





