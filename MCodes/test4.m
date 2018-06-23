%close all;
figure;
load (['e:/kaggle/seizure/train_1/1_1_0.mat']);
data=dataStruct.data;
for i=1:4
    subplot(4,1,i);
    plot(data(1:400,i));
end