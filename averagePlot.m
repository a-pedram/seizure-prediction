%close all;
for p=1:3
figure;
s=size(safeFiles{p}.zeros,1);
for i=1:10:size(safeFiles{p}.zeros,1)
    file = safeFiles{p}.zeros.image{i};
    avg = allAverages{p}.zeros.(['tr' file(1:end-4)]);
    avg = avg ./ max(avg);
    plot(avg,'color',[0 0 i/s],'marker','o');hold on;
end
for i=1:6:size(safeFiles{p}.ones,1)
    file = safeFiles{p}.ones.image{i};
    avg = allAverages{p}.ones.(['tr' file(1:end-4)]);
    avg = avg ./ max(avg);
    plot(avg,'color','r','marker','s');hold on;
end
end