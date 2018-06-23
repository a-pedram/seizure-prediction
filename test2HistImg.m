close all;


img=zeros(14,16);
histImagesTest=cell(3,1);

for p=1:3
    files = dir(['D:\kaggle\seizure\test_' num2str(p) '_new\']);
    for j=3:size(files,1)
        fprintf('%d %d\n',p,j);
        load(['D:\kaggle\seizure\test_' num2str(p) '_new\' files(j).name]);
        for i=1:16
            img(:,i)=log(stdHist(dataStruct.data(2:end,i)-dataStruct.data(1:end-1,i)));
        end
        histImagesTest{p}.(['ts' files(j).name(1:end-4)])=img;        
    end
end
save ./variables/histImagesTest.mat histImagesTest