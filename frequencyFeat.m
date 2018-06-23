function myFreqFeat = frequencyFeat(dataStruct,fileName)
L=240000;
Fs = 400;
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
halfF= NFFT/2+1;
k=(NFFT/2+1)/200;
log13 = log(1.3212);
for i=1:16
        y = zeros(50,1);
        c1 = dataStruct.data(:,i);%+s';                
        Y = abs(fft(c1,NFFT)/L);     
        for j=1:halfF 
            ksd = (j/k)+1;
            idx = floor(log(ksd)/log13 +1);
            y(idx)=y(idx)+Y(j);
        end                
        sy=sum(Y)/2;
        myFreqFeat.frequencies(i,:)= y(1:19)';
        myFreqFeat.SumFreq(i) = sy;
        myFreqFeat.file = fileName;
        myFreqFeat.Result = str2double(fileName(end-4));
end
end