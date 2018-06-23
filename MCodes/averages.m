clear all;
pnAvgs = cell(3,1);
absAvgs =  cell(3,1);
for p=1:3
files = dir(['e:/kaggle/seizure/train_' num2str(p) '/']);
for fn=3:size(files,1);
    path = [['e:/kaggle/seizure/train_' num2str(p) '/'] files(fn).name   ];
    load(path)    
    ss= zeros(100,1);
    sz=0;         
    result = str2double(files(fn).name(end-4));
    pnAvgs{p}(fn-2,:) = [mean(dataStruct.data) result ];
    absAvgs{p}(fn-2,:) = [mean(abs(dataStruct.data)) result ];
    fprintf('%d %d %s\n',p ,fn,files(fn).name);
end
end
save './variables/averages.mat' pnAvgs absAvgs;
