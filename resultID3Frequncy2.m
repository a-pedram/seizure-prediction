

fid = fopen('d:/res.csv','w');
fprintf(fid,'File,Class\n');
answers=cell(3,1);
fileNames=cell(3,1);
fileNames{1}=cell(1584,1);
fileNames{2}=cell(2256,1);
fileNames{3}=cell(2286,1);
for p=1:3    
fFile = ['.\variables\clustersP' num2str(p) '.mat'];
load(fFile);
clusterNums=zeros(size(myFeatures{p}{1},2) ,19);
ss= zeros(16,19);
for F=1:19
    for i=1:size(myFeatures{p},2)
        dMin=99;
        for E=1:16
            ss(E,:)=myFeatures{p}{i}.frequencies(E,:)./max(myFeatures{p}{i}.frequencies(E,:));
        end
        sample= ss(:,F)';
        for j=1:size(clusters{F},1)
            d = sqrt(sum((clusters{F}(j,:)-sample).^2));
            if d<dMin
                dMin=d;
                minC=j;
            end
        end
        clusterNums(i,F)=minC;        
    end    
end
fFile = ['.\variables\id3TreeP' num2str(p) '.mat'];
load(fFile);
answers{p} = zeros(size(myFeatures{p},2),1);

for i=1:size(myFeatures{p},2);
    s= clusterNums(i,:);
    tr=tree;
    while true
        f= tr.feature;
        tr= tr.children{s(1,f)};
        if tr.IsLeaf
            break;
        end
    end
    answers{p}(i)= tr.result;
end


for i=1:size(myFeatures{p},2)
    fileNames{p}{i}= myFeatures{p}{i}.file;
    fprintf(fid,'%s,%g\n',myFeatures{p}{i}.file,answers{p}(i));
end
end
fclose(fid);