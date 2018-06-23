close all;
load '.\variables\safeAverage.mat'
avgs= cell(3,1);
for p=1:3
for i=1:size(safeFiles{p}.ones,1)
    file = safeFiles{p}.ones.image{i};
    avg = allAverages{p}.ones.(['tr' file(1:end-4)]);
    avg = avg ./ max(avg);
    avgs{p} = [avgs{p};avg];
end
    s=size(safeFiles{p}.zeros,1);
for i=1:size(safeFiles{p}.zeros,1)
    file = safeFiles{p}.zeros.image{i};
    avg = allAverages{p}.zeros.(['tr' file(1:end-4)]);
    avg = avg ./ max(avg);
    avgs{p} = [avgs{p};avg];
end
end

est=cell(3,1);
for p=1:3
    est{p}=zeros(size(fieldnames( allAverages{p}.test),1),1);
end
results= cell(3,1);
for t=1:1
    t
for p=1:3    
    results{p}=zeros(3,100);
clusters = cell(3,1);
nc=0;
%indices = randperm(size(avgs{p},1));
for i=1:size(avgs{p},1)    
    dmin=999;
    c=-1;
    j=0;
    for j=1:nc
        d=sqrt(sum((avgs{p}(i,:)-clusters{p}(j,:)).^2));
        if d<dmin
            dmin=d;
            c=j;
        end
    end
    if dmin > .35 || c==-1
        nc=nc+1;
        clusters{p}(nc,:) = avgs{p}(i,:);
        nu(nc)=1;
    else
        clusters{p}(c,:) = (clusters{p}(c,:)*nu(c) + avgs{p}(i,:))/(nu(c)+1);
        nu(c)=nu(c)+1;
    end
end
for i=nc:-1:1
    if nu(i)<3
        clusters{p}(i,:)=[];
        nu(i)=[];
        nc=nc-1;
    end
end

for i=1:size(safeFiles{p}.ones,1)
    file = safeFiles{p}.ones.image{i};
    avg = allAverages{p}.ones.(['tr' file(1:end-4)]);
    avg = avg ./ max(avg);
    dmin=9999;
    for j=1:nc
        d = sqrt(sum((avg-clusters{p}(j,:)).^2));
        if d<dmin
            dmin=d;
            c =j;
        end
    end
    results{p}(2,c)=results{p}(2,c)+1;
end
s=size(safeFiles{p}.zeros,1);
for i=1:size(safeFiles{p}.zeros,1)
    file = safeFiles{p}.zeros.image{i};
    avg = allAverages{p}.zeros.(['tr' file(1:end-4)]);
    avg = avg ./ max(avg);
    dmin=9999;
    for j=1:nc
        d = sqrt(sum((avg-clusters{p}(j,:)).^2));
        if d<dmin
            dmin=d;
            c =j;
        end
    end
    results{p}(1,c)=results{p}(1,c)+1;
end



% figure;hold on;
% plot(clusters{3}(9,:),'color','r', 'marker','o');hold on;
% plot(clusters{3}(2,:),'color','b', 'marker','*');hold on;
% plot(clusters{3}(18,:),'color','g', 'marker','*');hold on;
% plot(clusters{3}(8,:),'color','c', 'marker','s')
files = fieldnames(allAverages{p}.test);
for i =1:size(files,1)
    file =files{i};
    avg = allAverages{p}.test.( file);
    avg = avg ./ max(avg);
    dmin=9999;
    for j=1:nc
        d = sqrt(sum((avg-clusters{p}(j,:)).^2));
        if d<dmin
            dmin=d;
            c =j;
        end
    end
    results{p}(3,c)=results{p}(3,c)+1;
    est{p}(i)=est{p}(i)+ (results{p}(2,c)+1)/(results{p}(1,c)+results{p}(2,c)+ 2);
end

end
end


fid= fopen('d:\safeAvg.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
%     est{p}=est{p}/t;
%     est{p}=(est{p}-mean(est{p}))/std(est{p});
files = fieldnames(allAverages{p}.test);
for i =1:size(files,1)
    file =files{i};
    fprintf(fid,'%s,%g\n',[file,'.mat'],est{p}(i));
end
end
fclose(fid);
estAvg=est