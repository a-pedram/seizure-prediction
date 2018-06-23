load ./variables/avgHistImage.mat;
load ./variables/histImages.mat;

readSafeFiles;
maxKN=60;
targets=cell(3,1);
%k= [18 16 12
nk= [25 34 45];
q=(1 ./(1:60))';
scores=cell(3,1);
cols={'r','g','b'};
figure('Name','Hist');
labels=[];
d1sHist2= cell(3,1);
for p=1:3
    numOfFiles = size(safeFiles{p}.all,1);
    us1 =zeros(numOfFiles,maxKN);
    d1 = zeros(numOfFiles,2);
    d1sHist2{p}= cell(numOfFiles,1);
%     d2 = zeros(size(trainIndices,2),2);
%     d3 = zeros(size(trainIndices,2),2);
%     d4 = zeros(size(trainIndices,2),2);
    for i=1:numOfFiles
        imgTest =histImages{p}.(['tr' safeFiles{p}.all.image{i}(1:end-4)]);
        imgTest(imgTest==-Inf) =0;
        d1sHist2{p}{i}= zeros(numOfFiles,2);
        for j=1:numOfFiles
            img =histImages{p}.(['tr' safeFiles{p}.all.image{j}(1:end-4)]);
            img(img==-Inf) =0;
            ansT=safeFiles{p}.all.class(j);
%              d1(j,2) = sum(sum(abs(imgTest-img)));
%              d1(j,1) =ansT;
             d1(j,2) = sqrt(sum(sum((imgTest-img).^2)));
             d1(j,1) =ansT;
%              d3(j,2) = sqrt(sum(sum((1-avgHistImage{p}.Importance) .*(imgTest-img).^2)));
%              d3(j,1) =ansT;
%              d4(j,2) = sum(sum(imgTest.*img))/norm(img);
%              d4(j,1) =ansT;
        end
        d1sHist2{p}{i}=d1;
        fprintf('p:%d i:%d\n',p,i);        
    end
save 'd:/d1sHist2.mat' d1sHist2;    
end
