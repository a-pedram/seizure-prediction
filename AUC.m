function AUCAns = AUC(ests,anss)
tbl= [ests anss];
tbl=sortrows(tbl,-1);
s=0;c=0;
z=0;o=0;
for i=1:size(tbl,1)
    if tbl(i,2)==1
        c=c+1;
        o=o+1;
    end
    if tbl(i,2)==0
        s=s+c;
        z=z+1;
    end    
end
AUCAns = s / (z*o);
end