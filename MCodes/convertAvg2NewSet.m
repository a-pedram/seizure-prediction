clear all;
readSafeFiles;

allAverages =cell(3,1);

for p=1:3
    s=size(safeFiles{p}.ones,1);
    for i=1:s
        file =safeFiles{p}.ones.image{i};
        load (['e:\kaggle\seizure\train_' num2str(p) '\' file ])
        allAverages{p}.ones.(['tr' file(1:end-4)]) = mean(abs(dataStruct.data));        
        fprintf('ones p:%d %d of %d\n',p,i,s)
    end    
    s=size(safeFiles{p}.zeros,1);
    for i=1:s
        file =safeFiles{p}.zeros.image{i};
        load (['e:\kaggle\seizure\train_' num2str(p) '\' file ])
        allAverages{p}.zeros.(['tr' file(1:end-4)]) = mean(abs(dataStruct.data));        
        fprintf('zeros p:%d %d of %d\n',p,i,s)
    end    
end

for p=1:3
    files = dir(['E:\kaggle\seizure\test_' num2str(p) '_new\']);
    s=size(files,1);
    for i=3:s
        file = files(i).name;
        load (['e:\kaggle\seizure\test_' num2str(p) '_new\' file ])
        allAverages{p}.test.(file(1:end-4))=mean(abs(dataStruct.data));
        fprintf('test p:%d %d of %d\n',p,i,s)
    end
end

save '.\variables\safeAverage.mat' allAverages