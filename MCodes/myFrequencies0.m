function y= myFrequencies0(wave,SampleRate,normalizeLocally)
L=size(wave,1);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
halfF= NFFT/2+1;
k=(NFFT/2+1)/(SampleRate/2);
log13 = log(1.3212);
h = size(wave,2);
y = zeros(20,h);
Y = abs(fft(wave,NFFT)/L);
for CH=1:h
    for j=1:halfF 
        ksd = (j/k)+1;
        idx = floor(log(ksd)/log13 +1);
        y(idx,CH)=y(idx,CH)+Y(j);    
    end
    if normalizeLocally==1
        mx = max(y(:,CH));
        if mx==0
            y(:,CH)=0;
        else
            y(:,CH)=y(:,CH) ./ max(y(:,CH));
        end
    end
end
y=y(1:19,:);
y=y(:);
if normalizeLocally==0
    mx = max(y);
    if mx==0
        y(:)=0;
    else
        y=y ./ max(y);
    end
end
end