close all;
clear all;
sumAnswers{1}=zeros(1584,1);
sumAnswers{2}=zeros(2256,1);
sumAnswers{3}=zeros(2286,1);
sumAnswers2{1}=zeros(1584,1);
sumAnswers2{2}=zeros(2256,1);
sumAnswers2{3}=zeros(2286,1);

for r= 1:30
    disp(r);
    load '.\variables\myFeaturesAll.mat';
    clusterFrequncyBands2;
    load '.\variables\answersID3Freq.mat';
    testID3;
    load '.\variables\frequencyTest.mat';
    resultID3Frequncy2;
    for p=1:3
        sumAnswers{p} = sumAnswers{p}+ answers{p};
    end
    
    load '.\variables\myFeaturesAll.mat';
    clusterFrequncyBands;
    load '.\variables\answersID3Freq.mat';
    testID3;
    load '.\variables\frequencyTest.mat';
    resultID3Frequncy;
    for p=1:3
        sumAnswers2{p} = sumAnswers2{p}+ answers2{p};
    end
end

fid = fopen('d:/avgFreqTuned.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(answers{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},sumAnswers{p}(i)/(2*r));
    end
end
fclose(fid);