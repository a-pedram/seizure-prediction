clear all;
readSafeFiles;
fImages= cell(3,1);
for p =1:3
    files = safeFiles{p}.all.image  ;
    for fn=1:size(safeFiles{p}.all,1)
        load(['d:\kaggle\seizure\train_' num2str(p) '\' safeFiles{p}.all.image{fn} ]);
        fImages{p}.(['tr' safeFiles{p}.all.image{fn}(1:end-4)])=myHRFrequencies(dataStruct.data,400,1);
        fprintf('Train: p:%d fn:%d\n',p,fn);
    end
end
for p =1:3
    files = dir(['d:\kaggle\seizure\test_' num2str(p) '_new\']);
    for fn=3:size(files,1)
        load(['d:\kaggle\seizure\test_' num2str(p) '_new\' files(fn).name]);
        fImages{p}.(['ts' files(fn).name(1:end-4)])=myHRFrequencies(dataStruct.data,400,1);
        fprintf('Test: p:%d fn:%d\n',p,fn);
    end
end
save 'd:/fImages.mat' fImages