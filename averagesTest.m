clear all;
pnAvgs = cell(3,1);
absAvgs =  cell(3,1);
for p=1:3
files = dir(['e:/kaggle/seizure/test_' num2str(p) '/']);
for fn=3:size(files,1);
    path = [['e:/kaggle/seizure/test_' num2str(p) '/'] files(fn).name   ];
    load(path)    
    pnAvgs{p}(fn-2,:) = mean(dataStruct.data);
    absAvgs{p}(fn-2,:) = mean(abs(dataStruct.data)) ;
    fprintf('%d %d\n',p ,fn);
end
end
save './variables/averagesTest.mat' pnAvgs absAvgs;