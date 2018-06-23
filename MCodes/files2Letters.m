close all;
clear all;


wl=1/(1.5)^2; %.44
wIndex=0;
while wl<600
    wIndex=wIndex+1;
    windowLengths(wIndex)= wl;    
    wl= wl*1.5;
end

load 'd:/lettersWinL.mat';
datasetLetterWinL = cell(18,1);
for wl=wIndex:-1:13
clusterRadius = sqrt(19 *(0.19 - wl * 0.004 )^2);

winSize = floor(240000 * (windowLengths(wl)/600));
lastWin = 240000 - winSize+1;
hWinSize = floor(winSize /2);

letters = lettrsWinL{wl,1};
datasetLetter=cell(3,1);
numOfWins = ceil((600/windowLengths(wl))*2);

for p=1:3
    files = dir(['e:/kaggle/seizure/train_' num2str(p) '/']);
    datasetLetter{p}=cell(size(files,1)-2,1);
    for fn=3:size(files,1)
        load(['e:/kaggle/seizure/train_' num2str(p) '/' files(fn).name]);
        datasetLetter{p}{fn-2}.fileName=files(fn).name;
        datasetLetter{p}{fn-2}.result =str2double(files(fn).name(end-4));
        datasetLetter{p}{fn-2}.data = zeros(numOfWins,16);
        for E=1:16
            seq=0;
            for sStart=1:hWinSize:lastWin
                seq= seq+1;
                frq= myFrequencies(dataStruct.data(sStart:sStart+winSize-1,E),400,1);
                dMin=999;
                for c=1:size(letters{p,E},2)
                    d= sqrt(sum((letters{p,E}(:,c) - frq).^2));
                    if d< dMin
                        dMin=d;
                        cMin=c;
                    end
                end
                datasetLetter{p}{fn-2}.data(seq,E)= cMin;
            end            
        end
        fprintf('wl:%d file:%d: %s \n',wl,fn-2,files(fn).name);
    end
end
datasetLetterWinL{wl}=datasetLetter;
end
