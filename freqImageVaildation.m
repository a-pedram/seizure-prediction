readSafeFiles;
load 'd:/fImages.mat';
load './variables/avgImages.mat'
est=cell(3,1);
mask =cell(3,1);

% mask{1}=ones(38,16);
% mask{2}=ones(38,16);
% mask{3}=ones(38,16);
mask =cell(3,1);
mask{1}=[ones(2,16)*.01;ones(7,16)*.9; ones(7,16);ones(22,16)*.05]; mask{1}(:,1:4)=0;mask{1}(:,8:9)=0;mask{1}(:,11:12)=0;
mask{2}=[ones(16,16);ones(22,16)*.1];mask{2}(:,10:11)=0;mask{2}(:,6:7)=0;mask{2}(:,13:16)=0;
mask{3}=[ones(2,16)*.02;ones(1,16)*1.69;ones(9,16)*1.15;ones(3,16)*.09;ones(14,16)*0;ones(2,16)*0.05;ones(7,16)*0];
mask{3}(:,9:12)= mask{3}(:,9:12)*0.15; mask{3}(:,14)=0; mask{3}(:,2:3)=0;
mask{3}(24:27,13:16)=.99;
mask{3}(24:27,1:4)=.05;
mask{3}(20:22,6:8)=.1;
pow=[ 1 3 1.1];
for p=1:3
    est{p} = zeros(size(safeFiles{p}.all,1),1);
    for i= 1: size(safeFiles{p}.all,1)
        fileName =safeFiles{p}.all.image{i}(1:end-4);
%         d2zero = (sum(sum((avgImages{p}.train0 - fImages{p}.(['tr' fileName])).^2)));
%         d2one  = (sum(sum((avgImages{p}.train1 - fImages{p}.(['tr' fileName])).^2)));  
        %Cosine product
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
    ,[est{1}*1.2;est{2};est{3}*1],1);
%[X,Y,T,AUC]=perfcurve([safeFiles{1}.all.class ;safeFiles{2}.all.class;safeFiles{3}.all.class],[est{1};est{2};est{3}],1);
    fprintf('AUC : %g\n',AUC);
    figure;plot(X,Y)