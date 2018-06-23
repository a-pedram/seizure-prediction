clear all;
pnAvgsTrain = cell(3,1);
absAvgsTrain =  cell(3,1);
pnAvgsValid = cell(3,1);
absAvgsValid =  cell(3,1);
numOfNegs=[1152,2196,2244] ./6;
for p=1:3
    [trainPos, validPos]= dividerand(25,.68,.32,0);
    bPath = ['e:/kaggle/seizure/train_' num2str(p) '/' num2str(p) '_'];
    t=0;v=0;
    for i=1: size(trainPos,2)
        for seq=1:6
            t =t+1;
            path = [bPath num2str((trainPos(i)-1)*6+seq) '_1.mat'];
            fprintf('%s \n',path );
            load(path);
            pnAvgsTrain{p}(t,:)=[mean(dataStruct.data) 1 ];
            absAvgsTrain{p}(t,:) = [mean(abs(dataStruct.data)) 1 ];
        end
    end
    for i=1: size(validPos,2)
        for seq=1:6
            v =v+1;
            path = [bPath num2str((validPos(i)-1)*6+seq) '_1.mat'];
            fprintf('%s \n',path );
            load(path);
            pnAvgsValid{p}(v,:)=[mean(dataStruct.data) 1 ];
            absAvgsValid{p}(v,:) = [mean(abs(dataStruct.data)) 1 ];
        end
    end
    [trainNeg, validNeg]= dividerand(numOfNegs(p),.68,.32,0);
    bPath = ['e:/kaggle/seizure/train_' num2str(p) '/' num2str(p) '_'];    
    for i=1: size(trainNeg,2)
        for seq=1:6
            t =t+1;
            path = [bPath num2str((trainNeg(i)-1)*6+seq) '_0.mat'];
            fprintf('%s \n',path );
            load(path);
            pnAvgsTrain{p}(t,:)=[mean(dataStruct.data) 0 ];
            absAvgsTrain{p}(t,:) = [mean(abs(dataStruct.data)) 0 ];
        end
    end
    for i=1: size(validNeg,2)
        for seq=1:6
            v =v+1;
            path = [bPath num2str((validNeg(i)-1)*6+seq) '_0.mat'];
            fprintf('%s \n',path );
            load(path);
            pnAvgsValid{p}(v,:)=[mean(dataStruct.data) 0 ];
            absAvgsValid{p}(v,:) = [mean(abs(dataStruct.data)) 0 ];
        end
    end    
end


pnAvgs = pnAvgsTrain;
absAvgs=absAvgsTrain;
save './variables/averagesTrain.mat' pnAvgs absAvgs
pnAvgs = pnAvgsValid;
absAvgs=absAvgsValid;
save './variables/averagesValid.mat' pnAvgs absAvgs