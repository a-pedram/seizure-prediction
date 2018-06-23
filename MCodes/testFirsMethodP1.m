files = dir('e:/kaggle/seizure/train_1/');

L=240000;
Fs = 400;
for fn=2:20
    path = ['e:/kaggle/seizure/train_1/1_' num2str(floor(fn/2)) '_' num2str(rem(fn,2)) '.mat' ]; %files(fn).name ];
    load(path)    
    ss= zeros(100,1);
    sz=0;
    for i=1:16
        y = zeros(201,1);
        c1 = dataStruct.data(:,i);%+s';
        NFFT = 2^nextpow2(L); % Next power of 2 from length of y
        %Y = fft(y,NFFT)/L;
        Y = abs(fft(c1,NFFT)/L);
        f = Fs/2*linspace(0,1,NFFT/2+1);
        k=(NFFT/2+1)/200;
        for j=1:NFFT/2+1        
            idx=floor(j/k)+1;
            y(idx)=y(idx)+Y(j);        
        end
        idx=0;
        yy= zeros(100,1);
        for j=1: size(y,1)
            idx=idx+2/j;
            ind=ceil(idx);
            yy(ind)=yy(ind)+y(j);
        end
        ss = ss +yy;
        %figure('Name', fName) ;plot([1:12],yy(1:12));
        if yy(12) > .7* max(yy)
            if yy(11) > 0.65 * max(yy)
                sz = sz +1;
            end
        end
    end
    fn
    answers(fn,:)=[ str2num(path(end-4))	sz];
    
end