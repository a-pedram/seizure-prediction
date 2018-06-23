sumAnswers =cell(3,1);
sumAnswers{1}=zeros(1584,1);
sumAnswers{2}=zeros(2256,1);
sumAnswers{3}=zeros(2286,1);

for r= 1:30
    disp(r);
    tic
    featureFilePath= '.\variables\myFeaturesP';
    clusterFrequncyBands;
    %clusterFrequncyBandsPlusR;
    testID3;
    testFilePath ='.\variables\test';
    resultID3Frequncy;
    for p=1:3
        sumAnswers{p} = sumAnswers{p}+ answers{p};
    end
    toc
end

for p=1:3
    sumAnswers{p} = sumAnswers{p} ./ r ;
end

fid = fopen('d:/avg10.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(answers{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},sumAnswers{p}(i));
    end
end
fclose(fid);