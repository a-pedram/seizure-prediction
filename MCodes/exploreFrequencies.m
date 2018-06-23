fName= '1_1063_0.mat';
path =['e:/kaggle/seizure/train_1/' fName];
load(path)
close all;
L=240000;
Fs = 400;

for i=1:16
    y = zeros(201,1);
    c1 = dataStruct.data(:,i);%+s';
    NFFT = 2^nextpow2(L); % Next pow er of 2 from length of y
    %Y = fft(y,NFFT)/L;
    Y = abs(fft(c1,NFFT)/L);
    f = Fs/2*linspace(0,1,NFFT/2+1);
    k=(NFFT/2+1)/200;
    for j=1:NFFT/2+1
        idx=floor(j/k)+1;
        y(idx)=y(idx)+Y(j);
    end
    figure('Name', fName) ;plot([1:100],y(1:100));
    %figure('Name', fName) ;plot(f,2*abs(Y(1:NFFT/2+1)));
    %ylim
end