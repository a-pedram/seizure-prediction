clear all;
load 'd:/kaggle/seizure/train_1/1_1_1.mat'
data = dataStruct.data(2:end,:)-dataStruct.data(1:end-1,:);
data2 = data.^2;
sd = sum(data2);
figure;plot(sd);

data3 = data.^3;
sd = sum(data3);
figure;plot(sd);