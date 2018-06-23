readSafeFiles;
load 'd:/fImages.mat';
load './variables/avgImages.mat'
load 'd:/d1sFreq.mat'
est=cell(3,1);
scores=cell(3,1);
cols={'r','g','b'};
load ./variables/mask1.mat;
load ./variables/mask2.mat;
load ./variables/mask3.mat;
 mask{1} = mask1;
mask{2} = mask2;
mask{3} = mask3;
pow=[ 1 3 1.1];
nk= [35 48 35];
maxKN=60;
q=(1 ./(1:maxKN))';
labels=[];

figure('Name','coreFreqImg');
for p=1:3
    p
    [trainIndices, testIndices]=dividerand(size(safeFiles{p}.all,1),.15,.85);
     us1 =zeros(size(testIndices,2),maxKN);
     us2 =zeros(size(testIndices,2),maxKN);
     us3 =zeros(size(testIndices,2),maxKN);
     us4 =zeros(size(testIndices,2),maxKN);
     us5 =zeros(size(testIndices,2),maxKN);
     us6 =zeros(size(testIndices,2),maxKN);
     us7 =zeros(size(testIndices,2),maxKN);
     d1 = zeros(size(trainIndices,2),2);
     d2 = zeros(size(trainIndices,2),2);
     d3 = zeros(size(trainIndices,2),2);
    est{p} = zeros(size(safeFiles{p}.all,1),1);  
    for i=1:size(testIndices,2)        
        imgTest =fImages{p}.(['tr' safeFiles{p}.all.image{testIndices(i)}(1:end-4)]);
        for j=1:size(trainIndices,2)
            img =fImages{p}.(['tr' safeFiles{p}.all.image{trainIndices(j)}(1:end-4)]);
            ansT=safeFiles{p}.all.class(trainIndices(j));
            d1(j,2) = sum(sum(abs(log(imgTest)-log(img))));
            d1(j,1) =ansT;
%             d2(j,2) = sqrt(sum(sum((imgTest-img).^2)));
%             d2(j,1) =ansT;
%             d3(j,2) = sqrt(sum(sum(avgHistImage{p}.Importance .*(imgTest-img).^2)));
%             d3(j,1) =ansT;
 %            d3(j,2) = sum(sum(imgTest.*img))/norm(img);
%             d3(j,1) =ansT;
        end
         d1= sortrows(d1,2);
% %        d2= sortrows(d2,2);
% %        d3= sortrows(d3,2);
%         d1=d1sFreq{p}{testIndices(i)}(trainIndices,:);
%         d1= sortrows(d1,2);
        for kn = 40:55% 1:maxKN
%             us1(i,kn) = sum(d1(1:kn,1)) / kn;
%             us2(i,kn) = sum(d1(1:kn,1) .* q(1:kn)) / sum(q(1:kn));
%             us3(i,kn) = sum(d1(1:kn,1) .* q(1:kn).^2) / sum(q(1:kn).^2);
%             us4(i,kn) = sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+1))) / sum((1./(d1(1:kn,2)-d1(1,2)+1)));
        if p==1
            us5(i,kn) = sum((d1(1:kn,1)-.1) .* (1./(d1(1:kn,2)-d1(1,2)+1))) / sum((1./(d1(1:kn,2)-d1(1,2)+1)));
        else
            us5(i,kn) = sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+1)).^2);
        end
%             us6(i,kn) = sum((d1(1:kn,1)-.1) .* (1./(d1(1:kn,2)-d1(1,2)+1))) / sum((1./(d1(1:kn,2)-d1(1,2)+1)));
%             us7(i,kn) = sum((d1(1:kn,1)-.1) .* (1./(d1(1:kn,2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+1)).^2);
        end
        fprintf('p:%d,i:%d\n',p,i);
    end
    allu1=zeros(1,maxKN);
    allu2=zeros(1,maxKN);
    allu3=zeros(1,maxKN);
    allu4=zeros(1,maxKN);
    allu5=zeros(1,maxKN);
    allu6=zeros(1,maxKN);
    allu7=zeros(1,maxKN);
    for kn=1:maxKN
    [X,Y,T,u1]=perfcurve(safeFiles{p}.all.class(testIndices),us1(:,kn),1);
    [X,Y,T,u2]=perfcurve(safeFiles{p}.all.class(testIndices),us2(:,kn),1);
    [X,Y,T,u3]=perfcurve(safeFiles{p}.all.class(testIndices),us3(:,kn),1);
    [X,Y,T,u4]=perfcurve(safeFiles{p}.all.class(testIndices),us4(:,kn),1);
    [X,Y,T,u5]=perfcurve(safeFiles{p}.all.class(testIndices),us5(:,kn),1);
    [X,Y,T,u6]=perfcurve(safeFiles{p}.all.class(testIndices),us6(:,kn),1);
    [X,Y,T,u7]=perfcurve(safeFiles{p}.all.class(testIndices),us7(:,kn),1);
        %fprintf('p:%d AUC kn%d: us1:%g \n',p,kn,u1);
        allu1(kn)=u1;
        allu2(kn)=u2;
        allu3(kn)=u3;
        allu4(kn)=u4;
        allu5(kn)=u5;
        allu6(kn)=u6;
        allu7(kn)=u7;
    end
%     plot(allu1,'color',cols{p},'LineStyle','-','LineWidth',1);hold on;
%     plot(allu2,'color',cols{p},'LineStyle',':','LineWidth',1);hold on;
%     plot(allu3,'color',cols{p},'LineStyle','--','LineWidth',1);hold on;
%     plot(allu4,'color',cols{p},'LineStyle','-.','LineWidth',1);hold on;
    plot(allu5,'color',cols{p},'LineStyle','-','LineWidth',2);hold on;
%     plot(allu6,'color',cols{p},'LineStyle',':','LineWidth',2);hold on;
%     plot(allu7,'color',cols{p},'LineStyle','--','LineWidth',2);hold on;
    scores{p} =[scores{p} us5(:,nk(p))];
    labels= [labels; safeFiles{p}.all.class(testIndices)];
    %figure;plot(X,Y)
end
sb = scores;

scores{1} = sb{1}*1.4+.19;
scores{2} = sb{2}*.9-.11;
scores{3} = sb{3}+.14;
for p=1:3
    scores{p}(isnan(scores{p}))=0;
end
[X,Y,T,AUC]=perfcurve(labels,[scores{1};scores{2};scores{3}],1);
AUC