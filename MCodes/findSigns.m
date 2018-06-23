close all;
clear all;
% 1  2   3    4
% 1 1.5 2.25 3.375 5.06 7.59 11.39 17 08 25.6 38.4 57


load 'e:/kaggle/seizure/train_1/1_1_1.mat';
seed = dataStruct;
min0 = zeros(20,600);
min1 = zeros(20,600);

windowLength=1;
while 1       
    
winSize = floor(240000 * (windowLength/600));
lastWin = 240000 - winSize+1;
qWinSize = winSize /4;
if windowLength>500
    break;
end
windowLength= windowLength*1.5;    

for f=2:110
    
    path = ['e:/kaggle/seizure/train_1/1_' num2str(f) '_1.mat'];
    load(path);
    dMin=999;
    for sStart=1:qWinSize:lastWin
        fprintf('0f:%d sStart:%d\n',f,sStart);
        symbol=myFrequencies(seed.data(sStart:sStart+winSize-1,:),400,1);        
        for wStart=1:qWinSize:lastWin
            frq = myFrequencies(dataStruct.data(wStart:wStart+winSize-1,:),400,1); 
            d = sqrt(sum((symbol - frq).^2));
            if d < dMin
                dMin=d;
                startMin=sStart;
            end
        end        
    end
    min0(windowLength,sStart)=min0(windowLength,sStart)+dMin;
end
for f=2:110    
    path = ['e:/kaggle/seizure/train_1/1_' num2str(f) '_0.mat'];
    load(path);
    dMin=999;
    for sStart=1:qWinSize:lastWin
        fprintf('1f:%d sStart:%d\n',f,sStart);
        symbol=myFrequencies(seed.data(sStart:sStart+winSize-1,:),400,1);        
        for wStart=1:qWinSize:lastWin
            frq = myFrequencies(dataStruct.data(wStart:wStart+winSize-1,:),400,1); 
            d = sqrt(sum((symbol - frq).^2));
            if d < dMin
                dMin=d;
                startMin=sStart;
            end
        end        
    end
    min1(windowLength,sStart)=min0(windowLength,sStart)+dMin;
end
end