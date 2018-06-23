readSafeFiles;
load 'd:/fImages.mat';
load './variables/avgImages.mat'
load 'd:/d1sFreq.mat'
load 'd:/d1sFreqLog.mat';
load 'd:/d1sFreqCorr.mat';
load 'd:/d1sFreqCorrTrans.mat';
load 'd:/d1sHist.mat';
load 'd:/d1sHist2.mat';
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
us= cell(3,1);
testIndices= cell(3,1);
for p=1:3    
    [trainIndices, testIndices{p}]= crossValidation(p); %dividerand(size(safeFiles{p}.all,1),.15,.85);
    us{p}= cell(17,1);
    for u=1:17
        us{p}{u}=zeros(size(testIndices{p},2),maxKN);
    end     
     d1 = zeros(size(trainIndices,2),2);
     d2 = zeros(size(trainIndices,2),2);     
     d3 = zeros(size(trainIndices,2),2);     
     d4 = zeros(size(trainIndices,2),2);     
     d5 = zeros(size(trainIndices,2),2);     
    est{p} = zeros(size(safeFiles{p}.all,1),1);  
    for i=1:size(testIndices{p},2)        
        d1=d1sFreq{p}{testIndices{p}(i)}(trainIndices,:);
        d2=d1sFreqCorr{p}{testIndices{p}(i)}(trainIndices,:);
        d3=d1sFreqLog{p}{testIndices{p}(i)}(trainIndices,:);
        d4=d1sHist2{p}{testIndices{p}(i)}(trainIndices,:);    %d1sFreqCorrTrans{p}{testIndices{p}(i)}(trainIndices,:);
        d5=d1sHist{p}{testIndices{p}(i)}(trainIndices,:);
        d1= sortrows(d1,2);
        d2= sortrows(d2,2);
        d3= sortrows(d3,2);
        d4= sortrows(d4,2);
        d5= sortrows(d5,2);
        for kn = 1:maxKN
            %us{p}{1}(i,kn) = sum(d1(1:kn,1)) / kn;
            us{p}{2}(i,kn) = sum(d1(1:kn,1) .* q(1:kn)) / sum(q(1:kn));
            us{p}{3}(i,kn) = sum(d1(1:kn,1) .* q(1:kn).^2) / sum(q(1:kn).^2);
            us{p}{4}(i,kn) = sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+1))) / sum((1./(d1(1:kn,2)-d1(1,2)+1)));
            us{p}{5}(i,kn) = sum(d1(1:kn,1) .* (1./(d1(1:kn,2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+1)).^2);
            us{p}{6}(i,kn) = sum((d1(1:kn,1)-.1) .* (1./(d1(1:kn,2)-d1(1,2)+1))) / sum((1./(d1(1:kn,2)-d1(1,2)+1)));
            us{p}{7}(i,kn) = sum((d1(1:kn,1)-.1) .* (1./(d1(1:kn,2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn,2)-d1(1,2)+1)).^2);
            us{p}{8}(i,kn) = sum(d2(1:kn,1)) / kn;
            us{p}{9}(i,kn) = sum(d2(1:kn,1) .* q(1:kn)) / sum(q(1:kn));
            us{p}{10}(i,kn) = sum(d2(1:kn,1) .* q(1:kn).^2) / sum(q(1:kn).^2);
            us{p}{11}(i,kn) = sum(d2(1:kn,1) .* (1./(d2(1:kn,2)-d2(1,2)+1))) / sum((1./(d2(1:kn,2)-d2(1,2)+1)));
            us{p}{12}(i,kn) = sum(d2(1:kn,1) .* (1./(d2(1:kn,2)-d2(1,2)+1)).^2) / sum((1./(d2(1:kn,2)-d2(1,2)+1)).^2);
            us{p}{13}(i,kn) = sum((d2(1:kn,1)-.1) .* (1./(d2(1:kn,2)-d2(1,2)+1))) / sum((1./(d2(1:kn,2)-d2(1,2)+1)));
            us{p}{14}(i,kn) = sum((d2(1:kn,1)-.1) .* (1./(d2(1:kn,2)-d2(1,2)+1)).^2) / sum((1./(d2(1:kn,2)-d2(1,2)+1)).^2);
            us{p}{15}(i,kn) = sum(d3(1:kn,1) .* (1./(d3(1:kn,2)-d3(1,2)+1)).^2) / sum((1./(d3(1:kn,2)-d3(1,2)+1)).^2);
            %us{p}{16}(i,kn) = sum(d4(1:kn,1) .* (1./(d4(1:kn,2)-d4(1,2)+1)).^2) / sum((1./(d4(1:kn,2)-d4(1,2)+1)).^2);
            %us{p}{17}(i,kn) = sum(d5(1:kn,1) .* (1./(d5(1:kn,2)-d5(1,2)+1)).^2) / sum((1./(d5(1:kn,2)-d5(1,2)+1)).^2);
            us{p}{16}(i,kn) = sum(d2(1:kn,1) .* ((d2(kn,2)-d2(1:kn,2))./(d2(kn,2)-d2(1,2)+.000001))) / sum(((d2(kn,2)-d2(1:kn,2))./(d2(kn,2)-d2(1,2)+.000001)));
            us{p}{17}(i,kn) = sum(d2(1:kn,1) .* ((d2(kn,2)-d2(1:kn,2))./(d2(kn,2)-d2(1,2)+.000001)).^2) / sum(((d2(kn,2)-d2(1:kn,2))./(d2(kn,2)-d2(1,2)+.000001)).^2);
        end
        fprintf('p:%d,i:%d\n',p,i);
    end    
    labels= [labels; safeFiles{p}.all.class(testIndices{p})];
    %figure;plot(X,Y)
end
figure;
for p=1:3
    %allu1=zeros(1,maxKN);
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
    allu15=zeros(1,maxKN);
    allu16=zeros(1,maxKN);
    allu17=zeros(1,maxKN);
    for kn=2:maxKN
        fprintf('p:%d kn:%d\n',p,kn);
    %[X,Y,T,u1]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{1}(:,kn),1);
    [X,Y,T,u2]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{2}(:,kn),1);
    [X,Y,T,u3]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{3}(:,kn),1);
    [X,Y,T,u4]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{4}(:,kn),1);
    [X,Y,T,u5]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{5}(:,kn),1);
    [X,Y,T,u6]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{6}(:,kn),1);
    [X,Y,T,u7]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{7}(:,kn),1);
    %[X,Y,T,u8]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{8}(:,kn),1);
    [X,Y,T,u9]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{9}(:,kn),1);
    [X,Y,T,u10]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{10}(:,kn),1);
    [X,Y,T,u11]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{11}(:,kn),1);
    [X,Y,T,u12]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{12}(:,kn),1);
    [X,Y,T,u13]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{13}(:,kn),1);
    [X,Y,T,u14]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{14}(:,kn),1);   
    [X,Y,T,u15]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{15}(:,kn),1);   
    [X,Y,T,u16]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{16}(:,kn),1);   
    [X,Y,T,u17]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us{p}{17}(:,kn),1);   
    
        %fprintf('p:%d AUC kn%d: us1:%g \n',p,kn,u1);
        %allu1(kn)=u1;
        allu2(kn)=u2;
        allu3(kn)=u3;
        allu4(kn)=u4;
        allu5(kn)=u5;
        allu6(kn)=u6;
        allu7(kn)=u7;
        %allu8(kn)=u8;
        allu9(kn)=u9;
        allu10(kn)=u10;
        allu11(kn)=u11;
        allu12(kn)=u12;
        allu13(kn)=u13;
        allu14(kn)=u14;    
        allu15(kn)=u15;
        allu16(kn)=u16;
        allu17(kn)=u17;
    end
    %plot(allu1,'color',cols{p},'LineStyle','-','LineWidth',1,'Marker','none');hold on;
    plot(allu2,'color',cols{p},'LineStyle',':','LineWidth',1,'Marker','none');hold on;
    plot(allu3,'color',cols{p},'LineStyle','--','LineWidth',1,'Marker','none');hold on;
    plot(allu4,'color',cols{p},'LineStyle','-.','LineWidth',1,'Marker','none');hold on;
    plot(allu5,'color',cols{p},'LineStyle','-','LineWidth',2,'Marker','none');hold on;
    plot(allu6,'color',cols{p},'LineStyle',':','LineWidth',2,'Marker','none');hold on;
    plot(allu7,'color',cols{p},'LineStyle','--','LineWidth',2,'Marker','none');hold on;
    %plot(allu8,'color',cols{p},'LineStyle','-','LineWidth',1,'Marker','s');hold on;
    plot(allu9,'color',cols{p},'LineStyle',':','LineWidth',1,'Marker','s');hold on;
    plot(allu10,'color',cols{p},'LineStyle','--','LineWidth',1,'Marker','s');hold on;
    plot(allu11,'color',cols{p},'LineStyle','-.','LineWidth',1,'Marker','s');hold on;
    plot(allu12,'color',cols{p},'LineStyle','-','LineWidth',2,'Marker','s');hold on;
    plot(allu13,'color',cols{p},'LineStyle',':','LineWidth',2,'Marker','s');hold on;
    plot(allu14,'color',cols{p},'LineStyle','--','LineWidth',2,'Marker','s');hold on;   
    plot(allu15,'color',cols{p},'LineStyle','--','LineWidth',2,'Marker','d');hold on;   
    plot(allu16,'color',cols{p},'LineStyle','-','LineWidth',1,'Marker','^');hold on;   
    plot(allu17,'color',cols{p},'LineStyle','-','LineWidth',1,'Marker','+');hold on;   
end
  ylim([.6 .95])
figure;
cols2=[1 .7 .7; .1 .6 .1; .7 0 1];
for p=1:3    
    p
    allu99=zeros(1,maxKN);   
    for kn=2:60
        if p==1
            usf=  .8*us{p}{5}(:,kn)+ us{p}{12}(:,kn) + .2 *us{p}{10}(:,kn)+ .035 *us{p}{15}(:,kn) + 0 *us{p}{16}(:,kn) + .02* us{p}{17}(:,kn);
        elseif p==2
            usf= .8* us{p}{5}(:,kn)+ 1*us{p}{12}(:,kn) + .3*us{p}{10}(:,kn) + .2 * us{p}{15}(:,kn)+ 0 *us{p}{16}(:,kn)+.09* us{p}{17}(:,kn);
        else
            usf=.9* us{p}{5}(:,kn)+ .4* us{p}{12}(:,kn)+ .01*us{p}{10}(:,kn) + 1.1 * us{p}{15}(:,kn)+0.001 *us{p}{16}(:,kn)+.002* us{p}{17}(:,kn);
        end
        [X,Y,T,u99]=perfcurve(safeFiles{p}.all.class(testIndices{p}),usf,1);
        allu99(kn)=u99;
    end
    scores{p}=usf;
     plot(allu99,'color',cols2(p,:),'LineStyle','-','LineWidth',2,'Marker','v');hold on;
end
   ylim([.6 .95])
sb = scores;

scores{1} = sb{1}*1;
scores{2} = sb{2}*1;
scores{3} = sb{3}*1;
[X,Y,T,AUC]=perfcurve(labels,[scores{1};scores{2};scores{3}],1);
AUC