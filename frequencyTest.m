%myFeatures = cell(3,1);
for p=1:2
files = dir(['e:/kaggle/seizure/test_' num2str(p) '/']);
L=240000;
Fs = 400;
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
halfF= NFFT/2+1;
k=(NFFT/2+1)/200;
log13 = log(1.3212);

for fn=3:size(files,1)
    path = ['e:/kaggle/seizure/test_' num2str(p) '/' files(fn).name ];
    load(path)    
    ss= zeros(50,1);
    sz=0;
    for i=1:16
        y = zeros(50,1);
        c1 = dataStruct.data(:,i);%+s';                
        Y = abs(fft(c1,NFFT)/L);                
        pidx=-9;        
        for j=1:halfF 
            ksd = (j/k)+1;
            idx = floor(log(ksd)/log13 +1);
            y(idx)=y(idx)+Y(j);
        end                
        sy=sum(Y)/2;
        myFeatures{p}{fn-2}.frequencies(i,:)= y(1:19)';
        myFeatures{p}{fn-2}.SumFreq(i) = sy;
        myFeatures{p}{fn-2}.file = files(fn).name;        
    end
    fprintf('%d %d\n',p,fn);
end
end
save './variables/FrequencyTest.mat' myFeatures;