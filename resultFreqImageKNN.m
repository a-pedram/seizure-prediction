readSafeFiles;
load 'd:/fImages.mat';
load './variables/avgImages.mat'
load d:/d1sFreqTest.mat;
est=cell(3,1);
scores1=cell(3,1);
scores2=cell(3,1);
scores3=cell(3,1);
scores4=cell(3,1);
cols={'r','g','b'};
pow=[ 1 3 1.1];

%kn= [55 55 55];
kn= [20 45 56;35 48 35; 55 40 48;50 55 55 ];
labels=[];
fileNames=cell(3,1);
%d1sFreqTest= cell(3,1);
for p=1:3
    
   est{p} = zeros(size(safeFiles{p}.all,1),1);
    files = dir(['e:\kaggle\seizure\test_' num2str(p) '_new\']);
    numOfFiles= size(files,1)-2;
     us1 =zeros(numOfFiles,1);
     us2 =zeros(numOfFiles,1);
     us3 =zeros(numOfFiles,1);
     us4 =zeros(numOfFiles,1);
     d1 = zeros(numOfFiles,2);
     d2 = zeros(numOfFiles,2);
     d3 = zeros(numOfFiles,2);
     d4 = zeros(numOfFiles,2);
    %d1sFreqTest{p}= cell(numOfFiles,1);
    trainSize=size(safeFiles{p}.all.image,1);
    fileNames{p}=cell(numOfFiles,1);
    est{p} = zeros(numOfFiles,1);
    for i= 1: numOfFiles
        fileNames{p}{i}=files(i+2).name;
        %d1sFreqTest{p}{i}= zeros(trainSize,2);
        imgTest =fImages{p}.(['ts' files(i+2).name(1:end-4)]);
        
        for j=1:trainSize
            img =fImages{p}.(['tr' safeFiles{p}.all.image{j}(1:end-4) ]);
            ansT=safeFiles{p}.all.class(j);
            d1(j,2) = sum(sum(abs(imgTest-img)));
            d1(j,1) =ansT;
            d2(j,2) = sum(sum(abs(log(imgTest)-log(img))));
            d2(j,1) =ansT;
            d3(j,2) = sum(sum(abs(corrcoef(imgTest)-corrcoef(img))));
            d3(j,1) =ansT;
            d4(j,2) = sum(sum(abs(corrcoef(imgTest')-corrcoef(img'))));
            d4(j,1) =ansT;
        end
%        d1=d1sFreqTest{p}{i};
        d1= sortrows(d1,2);
        d2= sortrows(d2,2);
        d3= sortrows(d3,2);
        d4= sortrows(d4,2);
        if p == 1
            us1(i)=sum(d1(1:kn(1,p),1) .* q(1:kn(1,p)).^2) / sum(q(1:kn(1,p)).^2);  %us1(i) = sum(d1(1:kn(p),1)) / kn(p);
            us2(i)=sum((d2(1:kn(2,p),1)-.1) .* (1./(d2(1:kn(2,p),2)-d2(1,2)+1))) / sum((1./(d2(1:kn(2,p),2)-d2(1,2)+1)));
            us3(i)=sum(d3(1:kn(3,p),1) .* (1./(d3(1:kn(3,p),2)-d3(1,2)+1)).^2) / sum((1./(d3(1:kn(3,p),2)-d3(1,2)+1)).^2);
            us4(i)=sum((d4(1:kn(4,p),1)-.1) .* (1./(d4(1:kn(4,p),2)-d4(1,2)+1))) / sum((1./(d4(1:kn(4,p),2)-d4(1,2)+1)));
        elseif p==2
            us1(i)=sum(d1(1:kn(1,p),1) .* (1./(d1(1:kn(1,p),2)-d1(1,2)+1)).^2) / sum((1./(d1(2:kn(1,p),2)-d1(1,2)+1)).^2);
            us2(i)=sum(d2(1:kn(2,p),1) .* (1./(d2(1:kn(2,p),2)-d2(1,2)+1)).^2) / sum((1./(d2(1:kn(2,p),2)-d2(1,2)+1)).^2);
            us3(i)=sum(d3(1:kn(3,p),1) .* (1./(d3(1:kn(3,p),2)-d3(1,2)+1)).^2) / sum((1./(d3(1:kn(3,p),2)-d3(1,2)+1)).^2);
            us1(i)=sum((d4(1:kn(4,p),1)-.1) .* (1./(d4(1:kn(4,p),2)-d4(1,2)+1)).^2) / sum((1./(d4(1:kn(4,p),2)-d4(1,2)+1)).^2);
        else
            us1(i)=sum((d1(1:kn(1,p),1)-.1) .* (1./(d1(1:kn(1,p),2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn(1,p),2)-d1(1,2)+1)).^2);
            us2(i)=sum(d2(1:kn(2,p),1) .* (1./(d2(1:kn(2,p),2)-d2(1,2)+1)).^2) / sum((1./(d2(1:kn(2,p),2)-d2(1,2)+1)).^2);
            us3(i)=sum(d3(1:kn(3,p),1) .* (1./(d3(1:kn(3,p),2)-d3(1,2)+1)).^2) / sum((1./(d3(1:kn(3,p),2)-d3(1,2)+1)).^2);
            us4(i)=sum(d4(1:kn(4,p),1) .* (1./(d4(1:kn(4,p),2)-d4(1,2)+1)).^2) / sum((1./(d4(1:kn(4,p),2)-d4(1,2)+1)).^2);
        end
        %us1(i)=sum((d1(1:kn(p),1)-.1) .* (1./(d1(1:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn(p),2)-d1(1,2)+1)).^2);
       fprintf('p:%d %d of %d\n',p,i,numOfFiles);
    end    
    scores1{p} = us1;
    scores2{p} = us2;
    scores3{p} = us3;
    scores4{p} = us4;
end
%save d:/d1sFreqTest.mat d1sFreqTest
sbF1 = scores1;
scores1{1} = sbF1{1}*1;
scores1{2} = sbF1{2}*1;
scores1{3} = sbF1{3}*1;
fid = fopen('d:/freqImgKNN.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},scores1{p}(i));
    end
end
fclose(fid);

sbF2 = scores2;
scores2{1} = sbF2{1}*1;
scores2{2} = sbF2{2}*1;
scores2{3} = sbF2{3}*1;
fid = fopen('d:/freqImgKNNLog.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},scores2{p}(i));
    end
end
fclose(fid);

sbF3 = scores3;
scores3{1} = sbF3{1}*1;
scores3{2} = sbF3{2}*1;
scores3{3} = sbF3{3}*1;
fid = fopen('d:/freqImgKNNCor.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},scores3{p}(i));
    end
end
fclose(fid);

sbF4 = scores4;
scores4{1} = sbF4{1}*1;
scores4{2} = sbF4{2}*1;
scores4{3} = sbF4{3}*1;
fid = fopen('d:/freqImgKNNCorTrans.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},scores4{p}(i));
    end
end
fclose(fid);