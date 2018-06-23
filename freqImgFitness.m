
est{p} = zeros(size(safeFiles{p}.all,1),1);
qMask0 = avgImages{p}.Importance .* mask .* avgImages{p}.train0 ;
qMask1 = avgImages{p}.Importance .* mask .* avgImages{p}.train1;
for i= 1: size(safeFiles{p}.all,1)
    fileName =safeFiles{p}.all.image{i}(1:end-4);
%         d2zero = (sum(sum((avgImages{p}.train0 - fImages{p}.(['tr' fileName])).^2)));
%         d2one  = (sum(sum((avgImages{p}.train1 - fImages{p}.(['tr' fileName])).^2)));  
    %Cosine product
    d2zero = sum(sum(qMask0 .* fImages{p}.(['tr' fileName])));
    d2one  = sum(sum(qMask1 .* fImages{p}.(['tr' fileName])));
    est{p}(i)= (d2one/d2zero);
    if isnan(est{p}(i))
        est{p}(i)=1;
    end
    %fprintf('%s: 2one:%g 2Zero:%g %g\n',fileName,d2one,d2zero,d2zero/d2one);
end
m= mean(est{p});
est{p}(est{p}==1)=m;%-std(est{p})/4;

[X,Y,T,AUC]=perfcurve(safeFiles{p}.all.class,est{p},1);
%fprintf('%g\n',AUC);



