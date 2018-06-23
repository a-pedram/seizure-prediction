clear all;
figure;
for j =5:6:150       
    sum0f=zeros(1,16);
    sum1f=zeros(1,16);
    for i=j:j%j:j+9;            
        load(['e:/kaggle/seizure/train_1/1_' num2str(i) '_0.mat']);
        f1 = myHRFrequencies(dataStruct.data(1:60000,:));
        f2 = myHRFrequencies(abs(dataStruct.data(180000:240000,:));        
        sum0f = sum0f + (f2-f1);
    end
    sum0f = sum0f/i;

    for i=j:j%j:j+9;            
        load(['e:/kaggle/seizure/train_1/1_' num2str(i) '_1.mat']);
        f1 = sum(abs(dataStruct.data(1:60000,:)));
        f2 = sum(abs(dataStruct.data(180000:240000,:)));        
        sum1f = sum0f + (f2-f1);
    end
    sum1f = sum1f/i;
    plot(sum0f);
    hold on;
    plot(sum1f,'Color','r');
    hold on;
end
