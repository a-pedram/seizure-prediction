close all;

load 'e:/kaggle/seizure/test_1/1_743.mat';
s1= dataStruct.data(:,1);
%s1=resample(double(s1),1,20);
load 'e:/kaggle/seizure/test_1/1_88.mat';
s2= dataStruct.data(:,1);
%s2=resample(double(s2),1,20);
ms=999999;
tic
for i=1:239900
    s=sum(abs(s1(1001:1050)-s2(i:i+49)));
    if s<ms
        ms= s;
        mi=i;
        fprintf('%g\n',ms);
    end
end
toc
figure;plot(s1(10001:10100));
figure;plot(s2(mi:mi+99));
figure;plot(s2(mi:mi+99)-s1(10001:10100));