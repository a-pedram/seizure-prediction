readSafeFiles;
load 'd:/fImages.mat';
load './variables/avgImages.mat'
load d:/d1sFreqTest.mat;
load d:/d1sHistTest.mat;

scores=cell(3,1);
knh= [30 30 30];
w=[.5 .5 0.5];
kn= [55 45 55];
labels=[];
fileNames=cell(3,1);
%d1sFreqTest= cell(3,1);
for p=1:3    
    files = dir(['d:\kaggle\seizure\test_' num2str(p) '_new\']);
    numOfFiles= size(files,1)-2;
     us1 =zeros(numOfFiles,1);
     us2 =zeros(numOfFiles,1);
     d1 = zeros(numOfFiles,2);
    %d1sFreqTest{p}= cell(numOfFiles,1);
    trainSize=size(safeFiles{p}.all.image,1);
    fileNames{p}=cell(numOfFiles,1);
    est{p} = zeros(numOfFiles,1);
    for i= 1: numOfFiles
        fileNames{p}{i}=files(i+2).name;
        d1=d1sFreqTest{p}{i};
        d1= sortrows(d1,2);
        d1h= d1sHistTest{p}{i};        
        d1h =sortrows(d1h,2);
        if p == 1
            us1(i)=sum(d1(1:kn(p),1) .* q(1:kn(p)).^2) / sum(q(1:kn(p)).^2);  %us1(i) = sum(d1(1:kn(p),1)) / kn(p);        
        elseif p==2
            us1(i)=sum(d1(1:kn(p),1) .* (1./(d1(1:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn(p),2)-d1(1,2)+1)).^2);                   
        else
            us1(i)=sum((d1(1:kn(p),1)-.1) .* (1./(d1(1:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn(p),2)-d1(1,2)+1)).^2);
        end
        us2(i)=sum(d1h(1:knh(p),1) .* q(1:knh(p))) / sum(q(1:knh(p)));        
        %us1(i)=sum((d1(1:kn(p),1)-.1) .* (1./(d1(1:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn(p),2)-d1(1,2)+1)).^2);
       fprintf('p:%d %d of %d\n',p,i,numOfFiles);
    end    
    us3 =  (us1+ us2 *w(p))/ (w(p)+1); 
    scores{p} =[scores{p} us3];
end
sbF = scores;

scores{1} = sbF{1}*1;
scores{2} = sbF{2}*1;
scores{3} = sbF{3}*1;
fid = fopen('d:/combFreqImgKNNweightedImgHistp1p1p1.csv','w');
fprintf(fid,'File,Class\n');
for p=1:3
    for i=1:size(fileNames{p},1)
        fprintf(fid,'%s,%g\n',fileNames{p}{i},scores{p}(i));
    end
end
fclose(fid);