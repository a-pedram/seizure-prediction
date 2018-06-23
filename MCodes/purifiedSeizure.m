readSafeFiles;
load d:/fImages.mat
p=3;
oneImages = cell(20,1);
dOnes = cell(100,1);
dZeros= cell(100,1);
figure('Name','dOnes');
for i=1:100 % size(safeFiles{p}.ones,1)
    oneImages{i}=fImages{p}.(['tr' safeFiles{p}.ones.image{i}(1:end-4)])(2:end-1,:);
    dOnes{i}= zeros(size(oneImages{i}));
    for j= 1:size(safeFiles{p}.ones,1)
        zImg=fImages{p}.(['tr' safeFiles{p}.ones.image{j}(1:end-4)])(2:end-1,:);
        dOnes{i} = dOnes{i} + oneImages{i} - zImg;
    end
    mx=max(dOnes{i}(:));
    dOnes{i}=dOnes{i} ;

    subplot(7,15,i);
    imshow(dOnes{i},[min(dOnes{i}(:)) max(dOnes{i}(:))]);
    title (mx);
i
end
figure('Name','dZeros');
for i=1:100 % size(safeFiles{p}.ones,1)
    oneImages{i}=fImages{p}.(['tr' safeFiles{p}.ones.image{i}(1:end-4)])(2:end-1,:);
    dZeros{i}= zeros(size(oneImages{i}));
    for j= 1:size(safeFiles{p}.zeros,1)
        zImg=fImages{p}.(['tr' safeFiles{p}.zeros.image{j}(1:end-4)])(2:end-1,:);
        dZeros{i} = dZeros{i} + oneImages{i} - zImg;
    end
    mx=max(dZeros{i}(:));
    dZeros{i}=dZeros{i} ;

    subplot(7,15,i);
    imshow(dZeros{i},[min(dZeros{i}(:)) max(dZeros{i}(:))]);
    title (mx);
i
end
figure('Name','dOnes - dZeros');
for i=1:100
    d= dZeros{i}-dOnes{i};
    subplot(7,15,i);
    imshow(d,[min(d(:)) max(d(:))]);
    title (max(d(:)));
end
figure('Name','ones');
for i=1:100
    d= fImages{p}.(['tr' safeFiles{p}.ones.image{i}(1:end-4)])(2:end-1,:);
    subplot(7,15,i);
    imshow(d,[min(d(:)) max(d(:))]);
    title (max(d(:)));
end
figure('Name','zeros');
for i=1:100
    d= fImages{p}.(['tr' safeFiles{p}.zeros.image{i}(1:end-4)])(2:end-1,:);
    subplot(7,15,i);
    imshow(d,[min(d(:)) max(d(:))]);
    title (max(d(:)));
end