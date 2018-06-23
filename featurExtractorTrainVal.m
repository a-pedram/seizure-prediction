clear all;
pnAvgsTrain = cell(3,1);
absAvgsTrain =  cell(3,1);
pnAvgsValid = cell(3,1);
absAvgsValid =  cell(3,1);
myFeaturesTrain = cell(3,1);
myFeaturesValid = cell(3,1);
numOfNegs=[1152,2196,2244] ./6;
for p=1:3
    [trainPos, validPos]= dividerand(25,.68,.32,0);
    bPath = ['e:/kaggle/seizure/train_' num2str(p) '/'];
    t=0;v=0;
    for i=1: size(trainPos,2)
        for seq=1:6
            t =t+1;
            fileName=[num2str(p) '_' num2str((trainPos(i)-1)*6+seq) '_1.mat'];
            path = [bPath fileName];
            fprintf('%s \n',path );
            load(path);
            pnAvgsTrain{p}(t,:)=[mean(dataStruct.data) 1 ];
            absAvgsTrain{p}(t,:) = [mean(abs(dataStruct.data)) 1 ];
            myFeaturesTrain{p}{t}=frequencyFeat(dataStruct,fileName);
        end
    end
    for i=1: size(validPos,2)
        for seq=1:6
            v =v+1;
            fileName=[num2str(p) '_' num2str((validPos(i)-1)*6+seq) '_1.mat'];
            path = [bPath fileName];
            fprintf('%s \n',path );
            load(path);
            pnAvgsValid{p}(v,:)=[mean(dataStruct.data) 1 ];
            absAvgsValid{p}(v,:) = [mean(abs(dataStruct.data)) 1 ];
            myFeaturesValid{p}{v}=frequencyFeat(dataStruct,fileName);
        end
    end
    [trainNeg, validNeg]= dividerand(numOfNegs(p),.68,.32,0);
    bPath = ['e:/kaggle/seizure/train_' num2str(p) '/' ];    
    for i=1: size(trainNeg,2)
        for seq=1:6
            t =t+1;
            fileName=[num2str(p) '_' num2str((trainNeg(i)-1)*6+seq) '_0.mat'];
            path = [bPath fileName];
            fprintf('%s \n',path );
            load(path);
            pnAvgsTrain{p}(t,:)=[mean(dataStruct.data) 0 ];
            absAvgsTrain{p}(t,:) = [mean(abs(dataStruct.data)) 0 ];
            myFeaturesTrain{p}{t}=frequencyFeat(dataStruct,fileName);
        end
    end
    for i=1: size(validNeg,2)
        for seq=1:6
            v =v+1;
            fileName=[num2str(p) '_' num2str((validNeg(i)-1)*6+seq) '_0.mat'];
            path = [bPath fileName];
            fprintf('%s \n',path );
            load(path);
            pnAvgsValid{p}(v,:)=[mean(dataStruct.data) 0 ];
            absAvgsValid{p}(v,:) = [mean(abs(dataStruct.data)) 0 ];
            myFeaturesValid{p}{v}=frequencyFeat(dataStruct,fileName);
        end
    end    
end


pnAvgs = pnAvgsTrain;
absAvgs=absAvgsTrain;
save './variables/averagesTrain.mat' pnAvgs absAvgs
pnAvgs = pnAvgsValid;
absAvgs=absAvgsValid;
save './variables/averagesValid.mat' pnAvgs absAvgs

myFeatures = myFeaturesValid;
save './variables/myFeaturesValid.mat' myFeatures;
myFeatures = myFeaturesTrain;
save './variables/myFeaturesTrain.mat' myFeatures;