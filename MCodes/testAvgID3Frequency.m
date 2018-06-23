close all;
clear all;

sumAnswers =cell(3,1);
sumAnswers{1}=zeros(414,1);
sumAnswers{2}=zeros(750,1);
sumAnswers{3}=zeros(768,1);
realAnswers=zeros(10000,1);
load '.\variables\myFeaturesValid.mat';
k=0;	
for p=1:3
    for i = 1:size(myFeatures{p},2)
        k=k+1;
        realAnswers(k)= myFeatures{p}{i}.Result;
    end    
end
realAnswers=realAnswers(1:k,1);

for r= 1:20
    %tic
    load '.\variables\myFeaturesTrain.mat';
    clusterFrequncyBands2;
    %clusterFrequncyBands;
    load '.\variables\answersID3Freq.mat';
    testID3;
    load  '.\variables\myFeaturesValid.mat';
    %resultID3Frequncy;
    resultID3Frequncy2;
    for p=1:3
        sumAnswers{p} = sumAnswers{p}+ answers{p};
    end
    %toc
    estAns=[];
    for p=1:3    
        estAns= [estAns;sumAnswers{p}./r];    
    end
    auc =AUC(estAns,realAnswers);
    [x y t au]= perfcurve(realAnswers,estAns,1);
    fprintf('r%d: My AUC:%g AU:%g\n',r,auc,au);
    figure;plot(x,y);
end


estAns=[];
for p=1:3
    sumAnswers{p} = sumAnswers{p} ./ r ;
    estAns= [estAns;sumAnswers{p}];    
end
AUC(estAns,realAnswers)
[x y t au]= perfcurve(realAnswers,estAns,1);
plot(x,y);