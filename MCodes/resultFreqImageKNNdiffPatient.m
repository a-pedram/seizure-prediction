readSafeFiles;
load 'd:/fImages.mat';
load './variables/avgImages.mat'
load d:/d1sFreqTest.mat;
est=cell(3,1);
scores=cell(3,1);
cols={'r','g','b'};
pow=[ 1 3 1.1];

%kn= [55 55 55];
kn= [50 30 27];
labels=[];
fileNames=cell(3,1);
%d1sFreqTest= cell(3,1);
for p=1:3
    
   est{p} = zeros(size(safeFiles{p}.all,1),1);
    files = dir(['e:\kaggle\seizure\test_' num2str(p) '_new\']);
    numOfFiles= size(files,1)-2;
     us1 =zeros(numOfFiles,1);
     d1 = zeros(numOfFiles,2);
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
            if p==1
                d1(j,2) = sum(sum(abs(corrcoef(imgTest)-corrcoef(img))));
            elseif p==2
                d1(j,2) = sum(sum(abs(log(imgTest)-log(img))));
            else
                d1(j,2) = sum(sum(abs(log(imgTest)-log(img))));
            end
            d1(j,1) =ansT;
%             d2(j,2) = sqrt(sum(sum((imgTest-img).^2)));
%             d2(j,1) =ansT;
%             d3(j,2) = sqrt(sum(sum(avgHistImage{p}.Importance .*(imgTest-img).^2)));
%             d3(j,1) =ansT;
%             d4(j,2) = sum(sum(imgTest.*img))/norm(img);
%             d4(j,1) =ansT;
        end
%        d1=d1sFreqTest{p}{i};
        d1= sortrows(d1,2);
        if p == 1
            us1(i)=sum(d1(2:kn(p),1) .* (1./(d1(2:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(2:kn(p),2)-d1(1,2)+1)).^2);     
        elseif p==2
            us1(i)=sum(d1(2:kn(p),1) .* (1./(d1(2:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(2:kn(p),2)-d1(1,2)+1)).^2);                   
        else
            us1(i)=sum(d1(2:kn(p),1) .* (1./(d1(2:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(2:kn(p),2)-d1(1,2)+1)).^2);
        end
        %us1(i)=sum((d1(1:kn(p),1)-.1) .* (1./(d1(1:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn(p),2)-d1(1,2)+1)).^2);
       fprintf('p:%d %d of %d\n',p,i,numOfFiles);
    end    
    scores{p} =[scores{p} us1];
%    labels= [labels; safeFiles{p}.all.class(testIndices)];
    %figure;plot(X,Y)
end
%save d:/d1sFreqTest.mat d1sFreqTest
sbF = scores;

scores{1} = sbF{1}*1;
scores{2} = sbF{2}*1;
scores{3} = sbF{3}*1;
fid = fopen('d:/freqImgKNNP_corP_logP_log.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},scores{p}(i));
    end
end
fclose(fid);