clear all;
fName= '1_105_1.mat';
path =['d:/kaggle/seizure/train_1/' fName];
load(path)
close all;
L=240000;
Fs = 400;
ss= zeros(100,1);
ssy=0;
for i=1:16
    y = zeros(201,1);
    c1 = dataStruct.data(:,i);%+s';
    NFFT = 2^nextpow2(L); % Next power of 2 from length of y
    %Y = fft(y,NFFT)/L;
    Y = abs(fft(c1,NFFT)/L);
    f = Fs/2*linspace(0,1,NFFT/2+1);
    k=(NFFT/2+1)/200;
    pidx=-9;
    halfF= NFFT/2+1;
    for j=1:halfF 
        ksd = (j/k)+1;
        idx = floor(log(ksd)/log(1.3212)+1);
        y(idx)=y(idx)+Y(j);
        if idx ~=pidx
            fprintf('%d %d %d \n',idx,floor(j/k),j);
            pidx=idx;            
        end        
    end
    sy=sum(Y)/2;
    ssy=ssy+sy;
    fprintf('---%d %d\n\n',i,sy);
    %figure('Name', fName) ;plot([1:100],y(1:100));
    figure('Name', fName) ;plot([1:20],y(1:20));
    %figure('Name', fName) ;plot(f,2*abs(Y(1:NFFT/2+1)));
    %ylim
end
ssy
%figure('Name', fName) ;plot([1:12],ss(1:12));