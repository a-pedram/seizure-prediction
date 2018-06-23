clear all;
for r=1:30
    load './variables/averages.mat'
    clusterAverages;
    load './variables/averagesTest.mat';
    %load './variables/clustersAvg.mat';
    resultAbsAvg;     
    if exist('avgAnswerAvg','var')
        avgAnswerAvg=avgAnswerAvg+answerAvg;        
    else
        avgAnswerAvg=answerAvg;
    end
    r
end
avgAnswerAvg=avgAnswerAvg /r ;



sumAnswers{1}=zeros(1584,1);
sumAnswers{2}=zeros(2256,1);
sumAnswers{3}=zeros(2286,1);

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
end

fid = fopen('d:/avgFreqTuned.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(answers{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},sumAnswers{p}(i));
    end
end
fclose(fid);

% fid = fopen('d:/mergeFREQnAbsAVG.csv','w');
% fprintf(fid,'File,Class\n');
% for p=1:3
%     for i=1:size(answers{p},1)
%         fprintf(fid,'%s,%g\n',fileNames{p}{i},(sumAnswers{p}(i)+avgAnswerAvg)/2);
%     end
% end
% fclose(fid);

fid= fopen('d:\mergeFreqAbsAVG.csv','w');
fprintf(fid,'File,Class\n');
k=0;
for p=1:3
files = dir(['e:/kaggle/seizure/test_' num2str(p) '/']);
for fn=3:size(files,1);
    k=k+1;
    fprintf(fid,'%s,%g\n',files(fn).name,(avgAnswerAvg(k)+avgAnswerAvg(k))/2);
end
end
fclose(fid);