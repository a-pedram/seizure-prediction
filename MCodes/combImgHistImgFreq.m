readSafeFiles;
load 'd:/fImages.mat';
load './variables/avgImages.mat'
load 'd:/d1sFreq.mat'
load 'd:/d1sHist2.mat'
est=cell(3,1);
scores=cell(3,1);
cols={'r','g','b'};
% mask{1} = mask1;
% mask{2} = mask2;
% mask{3} = mask3;
%trainIndices=cell(3,1);testIndices=cell(3,1);
pow=[ 1 3 1.1];
kn= [55 45 55];

knh= [30 30 30];
maxKN=60;
w=[.3 .1 0.3];
pfq=[1 .8 .9 ];
phq=[1 .7 .9];
w=[.3 .1 0.3];
pfq=[1 .8 .9 ];
phq=[1 1 1];
w=[.15 .05 0.01];
q=(1 ./(1:maxKN))';
labels=[];
for p=1:3
    %[trainIndices{p}, testIndices{p}]=dividerand(size(safeFiles{p}.all,1),.09,.91);
     us1 =zeros(size(testIndices{p},2),1);
     us2 =zeros(size(testIndices{p},2),1);
     us3 =zeros(size(testIndices{p},2),1);
     d1 = zeros(size(trainIndices{p},2),2);
     d2 = zeros(size(trainIndices{p},2),2);
     d3 = zeros(size(trainIndices{p},2),2);
    est{p} = zeros(size(safeFiles{p}.all,1),1);  
    for i=1:size(testIndices{p},2)        
        d1=d1sFreq{p}{testIndices{p}(i)}(trainIndices{p},:);
        d1h= d1sHist2{p}{testIndices{p}(i)}(trainIndices{p},:);
        d1= sortrows(d1,2);
        d1h =sortrows(d1h,2);
        if p == 1
            us1(i)=sum(d1(1:kn(p),1) .* q(1:kn(p)).^2) / sum(q(1:kn(p)).^2);  %us1(i) = sum(d1(1:kn(p),1)) / kn(p);        
        elseif p==2
            us1(i)=sum(d1(1:kn(p),1) .* (1./(d1(1:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn(p),2)-d1(1,2)+1)).^2);                   
        else
            us1(i)=sum((d1(1:kn(p),1)-.1) .* (1./(d1(1:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn(p),2)-d1(1,2)+1)).^2);
        end
        %us1(i) = sum(d1(1:kn(p),1) .* q(1:kn(p)).^2) / sum(q(1:kn(p)).^2);
        %us1(i) = sum(d1(1:kn(p),1) .* (1./(d1(1:kn(p),2)-d1(1,2)+.1))) / sum((1./(d1(1:kn(p),2)-d1(1,2)+.1)));        
        %us1(i) =  sum((d1(1:kn(p),1)-.1) .* (1./(d1(1:kn(p),2)-d1(1,2)+1)).^2) / sum((1./(d1(1:kn(p),2)-d1(1,2)+1)).^2);
        %us2(i) = sum(d1h(1:knh(p),1) .* q(1:knh(p)).^2) / sum(q(1:knh(p)).^2);
        us2(i)=sum(d1h(1:knh(p),1) .* q(1:knh(p))) / sum(q(1:knh(p)));        
        %us2(i)= sum(d1h(1:knh(p),1) .* (1./(d1h(1:knh(p),2)-d1h(1,2)+.1)).^2) / sum((1./(d1h(1:knh(p),2)-d1h(1,2)+.1)).^2);
        % 1 for p3   
    end
    us3 =  (us1*pfq(p)+ us2 *w(p) * phq(p))/ (w(p)+1);
    [X,Y,T,u1]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us1,1);
    [X,Y,T,u2]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us2,1);
    [X,Y,T,u3]=perfcurve(safeFiles{p}.all.class(testIndices{p}),us3,1);
    fprintf('p:%d imgFrq:%g HistImg:%g comb:%g growth:%g \n',p,u1,u2,u3,u3-max(u1,u2));
    scores{p} =[scores{p} us3];
    labels= [labels; safeFiles{p}.all.class(testIndices{p})];
    %figure;plot(X,Y)
end
sb = scores;
[X,Y,T,AUC1]=perfcurve(labels,[scores{1};scores{2};scores{3}],1);

scores{1} = sb{1}*1;
scores{2} = sb{2}*1.2;
scores{3} = sb{3}*1.02;
[X,Y,T,AUC2]=perfcurve(labels,[scores{1};scores{2};scores{3}],1);
fprintf('auc1:%g auc2:%g\n',AUC1,AUC2);
