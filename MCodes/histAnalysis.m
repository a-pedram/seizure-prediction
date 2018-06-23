close all;
readSafeFiles;
load 'd:/fImages.mat';


img=zeros(14,16);
histImages=cell(3,1);

for p=1:3
    for j=1:size(safeFiles{p}.all,1)
        fprintf('%d %d\n',p,j);
        load(['e:\kaggle\seizure\train_' num2str(p) '\' safeFiles{p}.all.image{j}]);
        for i=1:16
            img(:,i)=log(stdHist(dataStruct.data(2:end,i)-dataStruct.data(1:end-1,i)));
        end
        histImages{p}.(['tr' safeFiles{p}.all.image{j}(1:end-4)])=img;        
    end
end
save ./variables/histImages.mat histImages

avgHistImage=cell(3,1);
for p=1:3
    avgHistImage{p}.zero=zeros(14,16);
    avgHistImage{p}.one=zeros(14,16);
end
for p=1:3
    t=0;k=0;
    for i=1:size(safeFiles{p}.zeros,1)
        img =histImages{p}.(['tr' safeFiles{p}.zeros.image{i}(1:end-4)]);
        if sum(sum(img == -Inf))<17
            img(img == -Inf)=0;
        end
        s = sum(sum(img));
        if s > -Inf && s < Inf
            t= t+1;
            avgHistImage{p}.zero = avgHistImage{p}.zero + img;
        else
            k=k+1;
        end
    end
    k
    avgHistImage{p}.zero=avgHistImage{p}.zero /t;
    t=0;k=0;
    for i=1:size(safeFiles{p}.ones,1)
        img =histImages{p}.(['tr' safeFiles{p}.zeros.image{i}(1:end-4)]);
        if sum(sum(img == -Inf))<17
            img(img == -Inf)=0;
        end
        s = sum(sum(img));
        if s > -Inf && s < Inf
            t= t+1;
            avgHistImage{p}.one = avgHistImage{p}.one + img;
        else
            k=k+1;
        end
    end
    k
    avgHistImage{p}.one=avgHistImage{p}.one /t;
    avgHistImage{p}.Importance = abs(avgHistImage{p}.one - avgHistImage{p}.zero);
end
avgHistImage{2}.zero(:,10)=8;
avgHistImage{2}.one(:,10)=8;
save  ./variables/avgHistImage.mat avgHistImage
figure;
for p=1:3
    subplot(3,3,(p-1)*3+1);
    imshow(avgHistImage{p}.zero,[4.5 12]);
    subplot(3,3,(p-1)*3+2);
    imshow(avgHistImage{p}.one,[4.5 12]);
    subplot(3,3,(p-1)*3+3);
    d=abs(avgHistImage{p}.one-avgHistImage{p}.zero);
    [min(min(d))  max(max(d))]
    imshow(d,[min(min(d))  max(max(d))]);
end
