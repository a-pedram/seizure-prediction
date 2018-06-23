
answerAvg=[];
for p=1:3;
sa = size(pnAvgs{p},1);
answersAvgP=zeros(sa,1);
nc = size(clusters{p},1);
for i=1:sa
    dMin=999999;
    for j= 1:nc
        d = sqrt(sum((pnAvgs{p}(i,1:16) - clusters{p}(j,1:16)).^2));
        if d < dMin
            dMin =d;
            minC=j;            
        end
    end
    answersAvgP(i)= clusters{p}(minC,17);
end
answerAvg=[answerAvg;answersAvgP];
end