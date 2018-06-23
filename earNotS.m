nz = zeros(nc,1);

for f=1:150
    path = ['e:/kaggle/seizure/train_1/1_' num2str(f) '_0.mat'];
    load(path);        
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
        if dMin < 1.74
            nz(lMin)=nz(lMin)+1;
        end
        %fprintf('%g\n',dMin);
    end
        fprintf('file:%d \n',f);    
end

