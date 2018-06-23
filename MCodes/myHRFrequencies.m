function y= myHRFrequencies(wave,SampleRate,normalizeLocally)
L=size(wave,1);
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
halfF= NFFT/2+1;
k=(NFFT/2+1)/(SampleRate/2);
log13 = log(1.15);
h = size(wave,2);
y = zeros(40,h);
for CH=1:h    
    Y = abs(fft(wave(:,CH),NFFT)/L);
    for j=1:halfF 
        ksd = (j/k)+1;
        idx = floor(log(ksd)/log13 +1);
        y(idx,CH)=y(idx,CH)+Y(j);    
    end
    if normalizeLocally==1        
        mx = max(wave(:,CH));
        if mx==0
            %normalizeLocally
            y(:,CH)=0;
        else
            y(:,CH)=y(:,CH) ./ max(y(:,CH));
        end
    end
end
y=y(1:38,:);
if normalizeLocally==0
    mx = max(y);
    if mx==0
        y(:)=0;
    else
        y=y ./ max(y);
    end
end
end