clear all
readSafeFiles;

p=3
size(safeFiles{p}.all,1)
figure;
for i=1:3:size(safeFiles{p}.all,1)
    i
    load(['e:/kaggle/seizure/train_' num2str(p) '/' safeFiles{p}.all.image{i}]);
    d = dataStruct.data(2:end,:)- dataStruct.data(1:end-1,:);
    l = sum(abs(d));
    l = log((l- sum(dataStruct.data(dataStruct.data==0))) ./(240000- sum(dataStruct.data(dataStruct.data==0))));
    if safeFiles{p}.all.class(i) ==1
        plot(l,'color','r');hold on;
    else
        plot(l,'color','b');hold on;
    end
end
