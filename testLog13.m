files = dir('d:/kaggle/seizure/train_1/');
close all;
L=240000;
Fs = 400;
for fn=20:36
    path = ['d:/kaggle/seizure/train_1/1_' num2str(floor(fn/2)) '_' num2str(rem(fn,2)) '.mat' ]; %files(fn).name ];
    load(path)    
    ss= zeros(100,1);
    sz=0;
    for i=9:9
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
        figure('Name', path) ;plot([1:20],y(1:20));
        %figure('Name', fName) ;plot(f,2*abs(Y(1:NFFT/2+1)));
        %ylim
    end
    fn
    
end