readSafeFiles;
load d:/fImages.mat

oneImages = cell(3,1);

for p=1:3
%    [trainIndices, testIndices]=dividerand(size(safeFiles{p}.ones,1),.15,.85);
    oneImages{p} = zeros(150,38*16);    
    for i=1:150
        img=fImages{p}.(['tr' num2str(p) '_' num2str(i) '_1' ]);        
        oneImages{p}(i,:)=img(:);        
    end   
end

numOfClusters=[10 9 3];

for r1=2:1:16
s=0;
numOfClusters(1:3)=r1;
for r2= 1:4
oneClusters =cell(3,1);
for p=1:3
    [oneClusters{p}, numOfMems] = clusterKmeans(oneImages{p},numOfClusters(p));
    %numOfMems
end

% figure;
% for p=2:2
%     for i=1:numOfClusters(p)
%         img = reshape(oneClusters{p}(i,:),38,16);
%         subplot(3,numOfClusters(p),(p-1)*numOfClusters(p)+i);
%         imshow(img,[min(img(:)) max(img(:))]);
%     end
% end

for p=1:3
    dist= zeros(numOfClusters(p),1);
    numOfFiles =size(safeFiles{p}.all,1);
    labels = zeros(100,1);
    est =zeros(100,1);
    k=0;
    for i=1:numOfFiles   
        if strcmp(safeFiles{p}.all.image{i}(end-5:end-4), '_1')
            continue;
        end
        img = fImages{p}.(['tr' safeFiles{p}.all.image{i}(1:end-4)]);        
        img = img(:);
        k=k+1;
        labels(k) = safeFiles{p}.all.class(i);
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
        est(k)=(min(dist));
    end    
    [X,Y,T,AUC] = perfcurve(labels,est,1);
    fprintf('p:%d nc:%d %g\n',p,r1,AUC);
    %figure;plot(X,Y);
end
s=s+AUC;
end
fprintf('avg:%g\n',s/r2);
end



