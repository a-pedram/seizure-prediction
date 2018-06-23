readSafeFiles;
load 'd:/fImages.mat';
load './variables/avgImages.mat'
load 'd:/d1sFreq.mat'
est=cell(3,1);
scores=cell(3,1);
cols={'r','g','b'};
% load ./variables/mask1.mat;
% load ./variables/mask2.mat;
% load ./variables/mask3.mat;
%  mask{1} = mask1;
% mask{2} = mask2;
% mask{3} = mask3;
pow=[ 1 3 1.1];
nk= [25 34 45];
maxKN=60;
q=(1 ./(1:maxKN))';
labels=[];
figure;
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
     us8 =zeros(size(testIndices,2),maxKN);
     us9 =zeros(size(testIndices,2),maxKN);
     us10 =zeros(size(testIndices,2),maxKN);
     us11 =zeros(size(testIndices,2),maxKN);
     us12 =zeros(size(testIndices,2),maxKN);
     us13 =zeros(size(testIndices,2),maxKN);
     us14 =zeros(size(testIndices,2),maxKN);
     d1 = zeros(size(trainIndices,2),2);
     d2 = zeros(size(trainIndices,2),2);     
    est{p} = zeros(size(safeFiles{p}.all,1),1);  
    for i=1:size(testIndices,2)        
        imgTest =fImages{p}.(['tr' safeFiles{p}.all.image{testIndices(i)}(1:end-4)]);
        for j=1:size(trainIndices,2)
            img =fImages{p}.(['tr' safeFiles{p}.all.image{trainIndices(j)}(1:end-4)]);
            ansT=safeFiles{p}.all.class(trainIndices(j));
            d1(j,2) = sum(sum(abs(imgTest-img)));
            d1(j,1) =ansT;
            d2(j,2) = sum(sum(abs(corrcoef(imgTest')-corrcoef(img'))));
            d2(j,1) =ansT;
            
%            d2(j,2) = sqrt(sum(sum((imgTest-img).^2)));
%            d2(j,1) =ansT;
%             d3(j,2) = sqrt(sum(sum(avgHistImage{p}.Importance .*(imgTest-img).^2)));
%             d3(j,1) =ansT;
%             d2(j,2) = sum(sum(imgTest.*img))/norm(img);
%             d2(j,1) =ansT;
        end
        d1= sortrows(d1,2);
        d2= sortrows(d2,2);
% % %        d3= sortrows(d3,2);
%         d1=d1sFreq{p}{testIndices(i)}(trainIndices,:);
%         d1= sortrows(d1,2);
        for kn = 1:maxKN
            us1(i,kn) = sum(d1(1:kn,1)) / kn;
            us2(i,kn) = sum(d1(1:kn,1) .* q(1:kn)) / sum(q(1:kn));
            us3(i,kn) = sum(d1(1:kn,1) .* q(1:kn).^2) / sum(q(1:kn).^2);
            us4(i,kn) = sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+1))) / sum((1./(d1(1:kn,2)-d1(1,2)+1)));
            us5(i,kn) = sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+1)).^2);
            us6(i,kn) = sum((d1(1:kn,1)-.1) .* (1./(d1(1:kn,2)-d1(1,2)+1))) / sum((1./(d1(1:kn,2)-d1(1,2)+1)));
            us7(i,kn) = sum((d1(1:kn,1)-.1) .* (1./(d1(1:kn,2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+1)).^2);
            us8(i,kn) = sum(d2(1:kn,1)) / kn;
            us9(i,kn) = sum(d2(1:kn,1) .* q(1:kn)) / sum(q(1:kn));
            us10(i,kn) = sum(d2(1:kn,1) .* q(1:kn).^2) / sum(q(1:kn).^2);
            us11(i,kn) = sum(d2(1:kn,1) .* (1./(d2(1:kn,2)-d2(1,2)+1))) / sum((1./(d2(1:kn,2)-d2(1,2)+1)));
            us12(i,kn) = sum(d2(1:kn,1) .* (1./(d2(1:kn,2)-d2(1,2)+1)).^2) / sum((1./(d2(1:kn,2)-d2(1,2)+1)).^2);
            us13(i,kn) = sum((d2(1:kn,1)-.1) .* (1./(d2(1:kn,2)-d2(1,2)+1))) / sum((1./(d2(1:kn,2)-d2(1,2)+1)));
            us14(i,kn) = sum((d2(1:kn,1)-.1) .* (1./(d2(1:kn,2)-d2(1,2)+1)).^2) / sum((1./(d2(1:kn,2)-d2(1,2)+1)).^2);
            
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
    allu8=zeros(1,maxKN);
    allu9=zeros(1,maxKN);
    allu10=zeros(1,maxKN);
    allu11=zeros(1,maxKN);
    allu12=zeros(1,maxKN);
    allu13=zeros(1,maxKN);
    allu14=zeros(1,maxKN);    
    for kn=1:maxKN
    [X,Y,T,u1]=perfcurve(safeFiles{p}.all.class(testIndices),us1(:,kn),1);
    [X,Y,T,u2]=perfcurve(safeFiles{p}.all.class(testIndices),us2(:,kn),1);
    [X,Y,T,u3]=perfcurve(safeFiles{p}.all.class(testIndices),us3(:,kn),1);
    [X,Y,T,u4]=perfcurve(safeFiles{p}.all.class(testIndices),us4(:,kn),1);
    [X,Y,T,u5]=perfcurve(safeFiles{p}.all.class(testIndices),us5(:,kn),1);
    [X,Y,T,u6]=perfcurve(safeFiles{p}.all.class(testIndices),us6(:,kn),1);
    [X,Y,T,u7]=perfcurve(safeFiles{p}.all.class(testIndices),us7(:,kn),1);
    [X,Y,T,u8]=perfcurve(safeFiles{p}.all.class(testIndices),us8(:,kn),1);
    [X,Y,T,u9]=perfcurve(safeFiles{p}.all.class(testIndices),us9(:,kn),1);
    [X,Y,T,u10]=perfcurve(safeFiles{p}.all.class(testIndices),us10(:,kn),1);
    [X,Y,T,u11]=perfcurve(safeFiles{p}.all.class(testIndices),us11(:,kn),1);
    [X,Y,T,u12]=perfcurve(safeFiles{p}.all.class(testIndices),us12(:,kn),1);
    [X,Y,T,u13]=perfcurve(safeFiles{p}.all.class(testIndices),us13(:,kn),1);
    [X,Y,T,u14]=perfcurve(safeFiles{p}.all.class(testIndices),us14(:,kn),1);
    
        %fprintf('p:%d AUC kn%d: us1:%g \n',p,kn,u1);
        allu1(kn)=u1;
        allu2(kn)=u2;
        allu3(kn)=u3;
        allu4(kn)=u4;
        allu5(kn)=u5;
        allu6(kn)=u6;
        allu7(kn)=u7;
        allu8(kn)=u8;
        allu9(kn)=u9;
        allu10(kn)=u10;
        allu11(kn)=u11;
        allu12(kn)=u12;
        allu13(kn)=u13;
        allu14(kn)=u14;        
    end
    plot(allu1,'color',cols{p},'LineStyle','-','LineWidth',1,'Marker','none');hold on;
    plot(allu2,'color',cols{p},'LineStyle',':','LineWidth',1,'Marker','none');hold on;
    plot(allu3,'color',cols{p},'LineStyle','--','LineWidth',1,'Marker','none');hold on;
    plot(allu4,'color',cols{p},'LineStyle','-.','LineWidth',1,'Marker','none');hold on;
    plot(allu5,'color',cols{p},'LineStyle','-','LineWidth',2,'Marker','none');hold on;
    plot(allu6,'color',cols{p},'LineStyle',':','LineWidth',2,'Marker','none');hold on;
    plot(allu7,'color',cols{p},'LineStyle','--','LineWidth',2,'Marker','none');hold on;
    plot(allu8,'color',cols{p},'LineStyle','-','LineWidth',1,'Marker','s');hold on;
    plot(allu9,'color',cols{p},'LineStyle',':','LineWidth',1,'Marker','s');hold on;
    plot(allu10,'color',cols{p},'LineStyle','--','LineWidth',1,'Marker','s');hold on;
    plot(allu11,'color',cols{p},'LineStyle','-.','LineWidth',1,'Marker','s');hold on;
    plot(allu12,'color',cols{p},'LineStyle','-','LineWidth',2,'Marker','s');hold on;
    plot(allu13,'color',cols{p},'LineStyle',':','LineWidth',2,'Marker','s');hold on;
    plot(allu14,'color',cols{p},'LineStyle','--','LineWidth',2,'Marker','s');hold on;

    scores{p} =[scores{p} us1(:,nk(p))];
    labels= [labels; safeFiles{p}.all.class(testIndices)];
    %figure;plot(X,Y)
end
sb = scores;

scores{1} = sb{1}*1.5;
scores{2} = sb{2}*0;
scores{3} = sb{3}*0;
[X,Y,T,AUC]=perfcurve(labels,[scores{1};scores{2};scores{3}],1);
AUC