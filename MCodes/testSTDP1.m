stdE =  cell(3,1);
for p=1:3
    files  = dir(['e:/kaggle/seizure/train_' num2str(p) '/']);
    for i=3:size(files,1)
        load(['e:/kaggle/seizure/train_' num2str(p) '/' files(i).name ]);
        stdE{p}(i).std = std(dataStruct.data);
        stdE{p}(i).fileName = files(i).name;
        stdE{p}(i).result = str2double(files(i).name(end-4));
        fprintf('%d %d\n',p,i);
    end
end
%save stdE