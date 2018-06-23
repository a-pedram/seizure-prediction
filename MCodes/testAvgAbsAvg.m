clear all;
for r=1:10
    fprintf('Run:%d\n',r);
    load './variables/averagesTrain.mat';
    clusterAverages;
    load './variables/averagesValid.mat';
    %load './variables/clustersAvg.mat';
    testAbsAvg;     
    if exist('avgAnswerAvg','var')
        avgAnswerAvg=avgAnswerAvg+answerAvg;        
    else
        avgAnswerAvg=answerAvg;
    end    
    AUC(avgAnswerAvg/r,[ absAvgs{1}(:,17) ;absAvgs{2}(:,17);absAvgs{3}(:,17)])
end
avgAnswerAvg=avgAnswerAvg /r ;
AUC(avgAnswerAvg,[ absAvgs{1}(:,17) ;absAvgs{2}(:,17);absAvgs{3}(:,17)])
[x y t au]= perfcurve([absAvgs{1}(:,17);absAvgs{2}(:,17);absAvgs{3}(:,17)],avgAnswerAvg,1);
plot(x,y)