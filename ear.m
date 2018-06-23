close all;
clear all;
windowLength=2;
winSize = 240000 * (windowLength/600);
lastWin = 240000 - winSize+1;
hWinSize = winSize /2;
numOfClusters=20000;
words= zeros(19*16,numOfClusters);
nc= 0;
nu = zeros(numOfClusters,1);
upFromFile= zeros(numOfClusters,1);
nuf= zeros(numOfClusters,1);
uTime= zeros(numOfClusters,1);
for f=1:150
    path = ['e:/kaggle/seizure/train_1/1_' num2str(f) '_1.mat'];
    load(path);
    
    nr=0;nk=0;
    for wStart=1:hWinSize:lastWin
        frq = myFrequencies(dataStruct.data(wStart:wStart+winSize-1,:),400,1);        
        dMin=999;
        for l= 1:nc
            d = sqrt(sum((words(:,l) - frq) .^ 2));
            if d < dMin
                dMin=d;
                lMin=l;
            end
        end
        if dMin > 2.89 % 0.15 avergae distance
            if nc <numOfClusters
                nc=nc+1;
                words(:,nc)= frq;
                nu(nc)=1;
                upFromFile(nc)=f;
                nuf(nc)=1;
                uTime(nc)=f+wStart/lastWin;
            else
                maxScore=-99;                    
                for i=1:numOfClusters
                    score = 1/nu(i) + 1/uTime(i) - nuf(i)/10;
                    if score >maxScore
                        maxScore=score;
                        bestPlace=i;
                    end                        
                end
                words(:,bestPlace)=frq;
                nu(bestPlace)=1;
                uTime(bestPlace)=f;
            end
            nr =nr+1;
        else
            words(:,lMin)=(words(:,lMin)*nu(lMin) + frq) /(nu(lMin)+1);
            nu(lMin) = nu(lMin)+1;
            uTime(lMin)=f+wStart/lastWin;
            if upFromFile(lMin)~= f
                upFromFile(lMin)=f;
                nuf(lMin)=nuf(lMin)+1;
            end
            
            nk=nk+1;
        end
        %fprintf('%g\n',dMin);
    end
        fprintf('file:%d nc:%d nk:%d nr:%d\n',f,nc,nk,nr);    
end
words=words(:,1:nc);
for i=nc:-1:1
    if nu(i)==1
        nc= nc-1;
        nu(i)=[];
        words(:,i)=[];
    end
end
nu= nu(1:nc);
save './variables/wordsOriginal.mat' words nu
