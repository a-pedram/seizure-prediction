readSafeFiles;
load 'd:/fImages.mat';
load './variables/avgImages.mat'
est=cell(3,1);
mask =cell(3,1);

mask{1} = mask1;
mask{2} = mask2;
mask{3} = mask3;
pow=[ 1 1 1];
for p=1:3
    est{p} = zeros(size(safeFiles{p}.all,1),1);
    for i= 1: size(safeFiles{p}.all,1)
        fileName =safeFiles{p}.all.image{i}(1:end-4);
        d2zero = (sum(sum(avgImages{p}.Importance .* mask{p} .*(avgImages{p}.train0 .* fImages{p}.(['tr' fileName])).^pow(p))));
        d2one  = (sum(sum(avgImages{p}.Importance .* mask{p} .*(avgImages{p}.train1 .* fImages{p}.(['tr' fileName])).^pow(p))));
        est{p}(i)= (d2one) /d2zero ;
        if isnan(est{p}(i))
            est{p}(i)=1;
        end
        %fprintf('%s: 2one:%g 2Zero:%g %g\n',fileName,d2one,d2zero,d2zero/d2one);
    end
    m= mean(est{p});
    est{p}(est{p}==1)=m;%-std(est{p})/4;
    est{p}= (est{p} - mean(est{p}))./std(est{p});
    
    [X,Y,T,AUC]=perfcurve(safeFiles{p}.all.class,est{p},1);
    fprintf('AUC p%d: %g max:%g min:%g mean:%g std:%g\n',p,AUC,max(est{p}),min(est{p}),mean(est{p}),std(est{p}));
    %figure;plot(X,Y)
end
est{1}=est{1}+6;
est{2}=est{2}+6;
est{3}=est{3}+6;
[X,Y,T,AUC]=perfcurve([safeFiles{1}.all.class ;safeFiles{2}.all.class;safeFiles{3}.all.class] ...
    ,[est{1}*1.2;est{2};est{3}*.97],1);
%[X,Y,T,AUC]=perfcurve([safeFiles{1}.all.class ;safeFiles{2}.all.class;safeFiles{3}.all.class],[est{1};est{2};est{3}],1);
    fprintf('AUC : %g\n',AUC);
    figure;plot(X,Y)