estFrqImgNor=est;
estAvgNor=estAvg;
for p=1:3
    estFrqImgNor{p}=(est{p}-mean(est{p}))/std(est{p});
    estAvgNor{p}=(estAvg{p}-mean(estAvg{p}))/std(estAvg{p});
end
newEst=est;
newEst{3}=(newEst{3}+.1*estAvgNor{3})/1.1;

fid= fopen('d:/frqImgPlusAvgforP3.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},newEst{p}(i));
    end
end
fclose(fid);