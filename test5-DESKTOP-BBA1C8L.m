%close all
figure;
for i=0:23
    load (['d:/kaggle/seizure/train_2/2_' num2str(i*6+3) '_0.mat']);
    subplot(4,10,i+1)
    data=dataStruct.data;
    f= myHRFrequencies(data,400,1);
    imshow(f);
end
figure;
for i=0:39
    load (['d:/kaggle/seizure/train_2/2_' num2str(i+1) '_1.mat']);
    subplot(4,10,i+1)
    data=dataStruct.data;
    f= myHRFrequencies(data,400,1);
    imshow(f);
end
figure;
for i=0:23
    load (['d:/kaggle/seizure/test_2/2_' num2str(i*6+3) '.mat']);
    subplot(4,10,i+1)
    data=dataStruct.data;
    f= myHRFrequencies(data,400,1);
    imshow(f);
end
figure;
for i=0:23
    load (['d:/kaggle/seizure/train_2/2_' num2str(i*6+3) '_0.mat']);
    subplot(4,10,i+1)
    data=dataStruct.data;
    f= myHRFrequencies(data,400,1);
    imshow(f);
end