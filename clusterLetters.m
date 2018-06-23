close all;
clear all;


wl=1/(1.5)^2; %.44
wIndex=0;
while wl<600
    wIndex=wIndex+1;
    windowLengths(wIndex)= wl;    
    wl= wl*1.5;
end

lettrsWinL= cell(wIndex);

for wl=wIndex:-1:1
clusterRadius = sqrt(19 *(0.19 - wl * 0.004 )^2);

winSize = floor(240000 * (windowLengths(wl)/600));
lastWin = 240000 - winSize+1;
hWinSize = floor(winSize /2);


letters = cell(3,16);
for p=1:3
    for E=1:16
        letters{p,E}= zeros(19,20000);
    end
end

for p=1:3
    nc= zeros(16,1);
    nu= zeros(20000,16);
    files = dir(['e:/kaggle/seizure/test_' num2str(p) '/']);
    for fn=3:size(files,1)
        load(['e:/kaggle/seizure/test_' num2str(p) '/' files(fn).name]);        
        for E=1:16
            ncc=0;
            for sStart=1:hWinSize:lastWin
                frq= myFrequencies(dataStruct.data(sStart:sStart+winSize-1,E),400,1);
                dMin=999;
                for c=1:nc(E)
                    d= sqrt(sum((letters{p,E}(:,c) - frq).^2));
                    if d< dMin
                        dMin=d;
                        cMin=c;
                    end
                end
                if dMin <= clusterRadius
                    letters{p,E}(:,cMin)= (letters{p,E}(:,cMin) * nu(cMin,E) + frq)/ (nu(cMin,E)+1);
                    nu(cMin,E)=nu(cMin,E)+1;
                else
                    ncc=ncc+1;
                    nc(E)=nc(E)+1;
                    letters{p,E}(:,nc(E))= frq;
                    nu(nc(E),E)=1;
                end
            end
            fprintf('%d: %s E:%d nc:%d ncc:%d\n',fn-2,files(fn).name,E,nc(E),ncc);
        end        
    end
    % remove sparse letters
    for E=1:16
        letters{p,E}=letters{p,E}(:,1:nc(E));
        lt5= find(nu(1:nc(E),E) < 5);
        letters{p,E}(:,lt5')=[];
    end
end
lettrsWinL{wl}=letters;
save 'c:\lettersWinL.mat' lettersWinL
end
