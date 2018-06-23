clear all;
for r=1:30
    load './variables/averages.mat'
    clusterPNAverages;
    load './variables/averagesTest.mat';
    %load './variables/clustersAvg.mat';
    resultPnAvg;     
    if exist('avgAnswerAvg','var')
        avgAnswerAvg=avgAnswerAvg+answerAvg;        
    else
        avgAnswerAvg=answerAvg;
    end
    r
end
avgAnswerAvg=avgAnswerAvg /r ;
fid= fopen('d:\pnAvg.csv','w');
fprintf(fid,'File,Class\n');
k=0;
for p=1:3
files = dir(['e:/kaggle/seizure/test_' num2str(p) '/']);
for fn=3:size(files,1);
    k=k+1;
    fprintf(fid,'%s,%g\n',files(fn).name,avgAnswerAvg(k));
end
end
fclose(fid);
