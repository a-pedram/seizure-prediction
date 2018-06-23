load ./variables/avgHistImage.mat;
load ./variables/histImages.mat;
load d:/d1sHist.mat
readSafeFiles;
maxKN=60;
targets=cell(3,1);
%k= [18 16 12
nk= [25 34 45];
q=(1 ./(1:60))';
scores=cell(3,1);
cols={'r','g','b'};
figure('Name','cor of Hist');
labels=[];
for p=1:3
    [trainIndices, testIndices]=dividerand(size(safeFiles{p}.all,1),.15,.85);
    us1 =zeros(size(testIndices,2),maxKN);
    us2 =zeros(size(testIndices,2),maxKN);
    us3 =zeros(size(testIndices,2),maxKN);
    us4 =zeros(size(testIndices,2),maxKN);
    us5 =zeros(size(testIndices,2),maxKN);
    us6 =zeros(size(testIndices,2),maxKN);
    us7 =zeros(size(testIndices,2),maxKN);    
    d1 = zeros(size(trainIndices,2),2);
%     d2 = zeros(size(trainIndices,2),2);
%     d3 = zeros(size(trainIndices,2),2);
%     d4 = zeros(size(trainIndices,2),2);
    for i=1:size(testIndices,2)
        imgTest =histImages{p}.(['tr' safeFiles{p}.all.image{testIndices(i)}(1:end-4)]);
        imgTest(imgTest==-Inf) =0;
        for j=1:size(trainIndices,2)
            img =histImages{p}.(['tr' safeFiles{p}.all.image{trainIndices(j)}(1:end-4)]);
            img(img==-Inf) =0;
            ansT=safeFiles{p}.all.class(trainIndices(j));
  %           d1(j,2) = sum(sum(abs(imgTest-img)));
 %            d1(j,1) =ansT;
              d1(j,2) = sqrt(sum(sum((corr(imgTest)-corr(img)).^2)));
              d1(j,1) =ansT;
%              d3(j,2) = sqrt(sum(sum((1-avgHistImage{p}.Importance) .*(imgTest-img).^2)));
%              d3(j,1) =ansT;
%              d4(j,2) = sum(sum(imgTest.*img))/norm(img);
%              d4(j,1) =ansT;
        end
%         d1=d1sHist{p}{testIndices(i)}(trainIndices,:);
        d1= sortrows(d1,2);
%         d2= sortrows(d2,2);
%         d3= sortrows(d3,2);
%         d4= sortrows(d4,-2);
        for kn = 1:maxKN             
            us1(i,kn) = sum(d1(1:kn,1)) / kn;
            us2(i,kn) = sum(d1(1:kn,1) .* q(1:kn)) / sum(q(1:kn));
            us3(i,kn) = sum(d1(1:kn,1) .* q(1:kn).^2) / sum(q(1:kn).^2);
            us4(i,kn) = sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+.1))) / sum((1./(d1(1:kn,2)-d1(1,2)+.1)));
            us5(i,kn) = sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+.1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+.1)).^2);
            us6(i,kn) = sum((d1(1:kn,1)-.1) .* (1./(d1(1:kn,2)-d1(1,2)+.1))) / sum((1./(d1(1:kn,2)-d1(1,2)+.1)));
            us7(i,kn) = sum((d1(1:kn,1)-.1) .* (1./(d1(1:kn,2)-d1(1,2)+.1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+.1)).^2);
        end
        fprintf('P:%d %d of %d\n',p,i,size(testIndices,2));
    end
    allu1=zeros(1,maxKN);
     allu2=zeros(1,maxKN);
    allu3=zeros(1,maxKN);
    allu4=zeros(1,maxKN);
    allu5=zeros(1,maxKN);
    allu6=zeros(1,maxKN);
    allu7=zeros(1,maxKN);
    
    for kn=1:60
        [X,Y,T,u1]=perfcurve(safeFiles{p}.all.class(testIndices),us1(:,kn),1);
         [X,Y,T,u2]=perfcurve(safeFiles{p}.all.class(testIndices),us2(:,kn),1);
        [X,Y,T,u3]=perfcurve(safeFiles{p}.all.class(testIndices),us3(:,kn),1);
        [X,Y,T,u4]=perfcurve(safeFiles{p}.all.class(testIndices),us4(:,kn),1);
        [X,Y,T,u5]=perfcurve(safeFiles{p}.all.class(testIndices),us5(:,kn),1);
        [X,Y,T,u6]=perfcurve(safeFiles{p}.all.class(testIndices),us6(:,kn),1);
        [X,Y,T,u7]=perfcurve(safeFiles{p}.all.class(testIndices),us7(:,kn),1);

        fprintf('p:%d AUC kn%d: us1:%g \n',p,kn,u1);
        
        allu1(kn)=u1;
        allu2(kn)=u2;
         allu3(kn)=u3;
         allu4(kn)=u4;
         allu5(kn)=u6;
         allu6(kn)=u6;
         allu7(kn)=u7;
    end
    plot(allu1,'color',cols{p},'LineStyle','-','LineWidth',1);hold on;
    plot(allu2,'color',cols{p},'LineStyle',':','LineWidth',1);hold on;
    plot(allu3,'color',cols{p},'LineStyle','--','LineWidth',1);hold on;
    plot(allu4,'color',cols{p},'LineStyle','-.','LineWidth',1);hold on;
    plot(allu5,'color',cols{p},'LineStyle','-','LineWidth',2);hold on;
    plot(allu6,'color',cols{p},'LineStyle',':','LineWidth',2);hold on;
    plot(allu7,'color',cols{p},'LineStyle','--','LineWidth',2);hold on;
    scores{p} =[scores{p} us2(:,nk(p))];
    labels= [labels; safeFiles{p}.all.class(testIndices)];
    %figure;plot(X,Y)
end
sb = scores;


scores{1} = sb{1}*1.05;
scores{2} = sb{2}*.6;
scores{3} = sb{3}*.99;
[X,Y,T,AUC]=perfcurve(labels,[scores{1};scores{2};scores{3}],1);
AUC
%figure;plot(X,Y)
