function feature =  ID3selectFeature(chunkNumber,usedFeatures)
global numOfValsFeature;
global trainData;
total = size(trainData{chunkNumber},1);
numOfFeatures = size(trainData{chunkNumber},2)-1;
infoGain= zeros(numOfFeatures,1);
%splitInfo= zeros(numOfFeatures,1);
%gainRatio= zeros(numOfFeatures,1);
for i=1:numOfFeatures
    if usedFeatures(i)==1;
        infoGain(i)=999;%!!
        %gainRatio(i)=99999999;
        continue;
    end
    numOfVals =numOfValsFeature(i);
    for j=1: numOfVals
        %               p
        sumV = sum(trainData{chunkNumber}(:,i)==j);
        sumVP= sum(trainData{chunkNumber}(:,i)==j & trainData{chunkNumber}(:,end)==2);
        p = sumVP/sumV;
        pp = 1 -p;
        if sumV==0 || sumV-sumVP ==0 || pp==1
            entV=0;
        else
            entV = - p * log2(p) - pp * log2(pp);        
        end
        
        infoGain(i)= infoGain(i) + (sumV/total) * entV;
%         if sumV~=0
%             splitInfo(i) =  splitInfo(i) - (sumV/total) * log2(sumV/total);        
%         end
    end
    %gainRatio(i) = infoGain(i)/splitInfo(i);
end
[~,feature] = min(infoGain);
%[~,feature] = min(gainRatio);
end