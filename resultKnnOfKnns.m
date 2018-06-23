clear all
load d:\scoresVectorTest.mat
load d:\scoresVector.mat
load ./variables/histImagesTest.mat;
kn=200;
q=(1 ./(1:kn))';
scores1=cell(3,1);
scores2=cell(3,1);
scores3=cell(3,1);
scores4=cell(3,1);
scores5=cell(3,1);
scores6=cell(3,1);
scores7=cell(3,1);
fileNames=cell(3,1);
qp=[ .8  1  .2  .03 0.01 0    .02;
     .8  1  .3  .2  0.01 0     .09;
     .9 .45 .01 1.1 0.01 0.002 0.002];

for p=1:3
    scoresVector{p}(isnan(scoresVector{p}))=0.5;
    scoresVectorTest{p}(isnan(scoresVectorTest{p}))=0.5;
    for i=1:7
        scoresVector{p}(:,i)=(scoresVector{p}(:,i)-mean(scoresVector{p}(:,i)))./std(scoresVector{p}(:,i));
        scoresVectorTest{p}(:,i)=(scoresVectorTest{p}(:,i)-mean(scoresVectorTest{p}(:,i)))./std(scoresVectorTest{p}(:,i));
        scoresVectorTest{p}(:,i)=qp(p,i)* scoresVectorTest{p}(:,i);
    end
end

for p=1:3
    fileNames{p} =fieldnames(histImagesTest{p});    
    testSize =size(fileNames{p},1);    
    trainSize = size(scoresVector{p},1);
    d1 = zeros(trainSize,2);
    d2 = zeros(trainSize,2);
    d3 = zeros(trainSize,2);
    for ts=1:testSize
        tstVector = scoresVectorTest{p}(ts,1:7);
        for tr=1:trainSize
            trVector=scoresVector{p}(tr,:);
            d1(tr,2)=sum(abs(trVector(1,1:7) - tstVector));
            d1(tr,1) = trVector(10);
            d2(tr,2)=sum((trVector(1,1:7) - tstVector).^2);
            d2(tr,1) = trVector(10);
            NN=(norm(trVector(1,1:7))*norm(tstVector));
            if NN==0
                d3(tr,2)=0;
            else
                d3(tr,2)=sum(trVector(1,1:7) .* tstVector) ./ NN;
            end
            d3(tr,1) = trVector(10);
        end
        d1 = sortrows(d1,2);
        d2 = sortrows(d2,2);
        d3 = sortrows(d3,-2);
        scores1{p}(ts)=sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+1)).^2);
        scores2{p}(ts)=sum(d2(1:kn,1) .* (1./(d2(1:kn,2)-d2(1,2)+1)).^2) / sum((1./(d2(1:kn,2)-d2(1,2)+1)).^2);
        scores3{p}(ts)=sum(d3(1:kn,1) .* (1./(d3(1:kn,2)-d3(1,2)+1)).^2) / sum((1./(d3(1:kn,2)-d3(1,2)+1)).^2);
        scores4{p}(ts)=sum(d1(1:kn,1) .* q(1:kn).^2) / sum(q(1:kn).^2);
        scores5{p}(ts)=sum(d2(1:kn,1) .* q(1:kn).^2) / sum(q(1:kn).^2);           
        scores6{p}(ts)=sum(d3(1:kn,1) .* q(1:kn).^2) / sum(q(1:kn).^2);
        scores7{p}(ts)=sum(d1(1:kn,1) .* ((d1(kn,2)-d1(1:kn,2))./(d1(kn,2)-d1(1,2)+.000001)).^2) / sum(((d1(kn,2)-d1(1:kn,2))./(d1(kn,2)-d1(1,2)+.000001)).^2);
        fprintf('p:%d ts:%d  D:%g\n',p,ts,d1(kn,2)-d1(1,2));
    end
end

fid= fopen('d:/KnnOfKnnS1.csv','w');
fprintf(fid,'File,Class\n');
s1q=[1.1 .85 1];
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',[fileNames{p}{i}(3:end) '.mat'],s1q(p) * scores1{p}(i));
    end
end
fclose(fid);

fid= fopen('d:/KnnOfKnnS2.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',[fileNames{p}{i}(3:end) '.mat'],scores2{p}(i));
    end
end
fclose(fid);

fid= fopen('d:/KnnOfKnnS3.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',[fileNames{p}{i}(3:end) '.mat'],scores3{p}(i));
    end
end
fclose(fid);

fid= fopen('d:/KnnOfKnnS4.csv','w');
%Best s4q=[1.1 .8 1];
s4q=[1.1 .8 1];
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',[fileNames{p}{i}(3:end) '.mat'],s4q(p)*scores4{p}(i));
    end
end
fclose(fid);

fid= fopen('d:/KnnOfKnnS5.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',[fileNames{p}{i}(3:end) '.mat'],scores5{p}(i));
    end
end
fclose(fid);

fid= fopen('d:/KnnOfKnnS6.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',[fileNames{p}{i}(3:end) '.mat'],scores6{p}(i));
    end
end
fclose(fid);

fid= fopen('d:/KnnOfKnnS7.csv','w');
fprintf(fid,'File,Class\n');
s7q=[1.1 .85 1];
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',[fileNames{p}{i}(3:end) '.mat'],s7q(p) * scores7{p}(i));
    end
end
fclose(fid);