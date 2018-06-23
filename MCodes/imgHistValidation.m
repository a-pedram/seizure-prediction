load ./variables/avgHistImage.mat;
load ./variables/histImages.mat;

readSafeFiles;
targets=cell(3,1);
%k= [18 16 12
%k= [8 16 12
scores=cell(3,1);
cols={'r','g','b'};
figure;
for p=1:3
    [trainIndices, testIndices]=dividerand(size(safeFiles{p}.all,1),.15,.85);
    us1 =zeros(size(testIndices,2),40);
    us2 =zeros(size(testIndices,2),1);
    us3 =zeros(size(testIndices,2),1);
    us4 =zeros(size(testIndices,2),1);
%     cs1 =zeros(size(safeFiles{p}.all,1),1);
%     cs2 =zeros(size(safeFiles{p}.all,1),1);
%     cs3 =zeros(size(safeFiles{p}.all,1),1);    
    d1 = zeros(size(trainIndices,2),2);
    d2 = zeros(size(trainIndices,2),2);
    d3 = zeros(size(trainIndices,2),2);
    d4 = zeros(size(trainIndices,2),2);
    for i=1:size(testIndices,2)
        imgTest =histImages{p}.(['tr' safeFiles{p}.all.image{testIndices(i)}(1:end-4)]);
        imgTest(imgTest==-Inf) =0;
        for j=1:size(trainIndices,2)
            img =histImages{p}.(['tr' safeFiles{p}.all.image{trainIndices(j)}(1:end-4)]);
            img(img==-Inf) =0;
            ansT=safeFiles{p}.all.class(trainIndices(j));
            d1(j,2) = sum(sum(abs(imgTest-img)));
            d1(j,1) =ansT;
%             d2(j,2) = sqrt(sum(sum((imgTest-img).^2)));
%             d2(j,1) =ansT;
%             d3(j,2) = sqrt(sum(sum(avgHistImage{p}.Importance .*(imgTest-img).^2)));
%             d3(j,1) =ansT;
%             d4(j,2) = sum(sum(imgTest.*img))/norm(img);
%             d4(j,1) =ansT;
        end
        d1= sortrows(d1,2);
%         d2= sortrows(d2,2);
%         d3= sortrows(d3,2);
%         d4= sortrows(d4,-2);
%          d5= sortrows(d5,-2);
        for kn = 1:40
            us1(i,kn) = sum(d1(1:kn,1)) / kn;
        end
        %us1(i) = sum(d1(1:k(p),1) .* q(1:k(p))) / sum(q(1:k(p)));
        
%         us2(i) = sum(d2(1:k(p),1))/ k(p);
%         us3(i) = sum(d3(1:k(p),1))/ k(p);
%         us4(i) = sum(d4(1:k(p),1))/ k(p);
%         if rem(i,200)==0
%             fprintf('p:%d %d\n',p,i);
%         end
    end
    allu=zeros(1,40);
    for kn=1:40
    [X,Y,T,u1]=perfcurve(safeFiles{p}.all.class(testIndices),us1(:,kn),1);
%     [X,Y,T,u2]=perfcurve(safeFiles{p}.all.class(testIndices),us2,1);
%     [X,Y,T,u3]=perfcurve(safeFiles{p}.all.class(testIndices),us3,1);
%     [X,Y,T,u4]=perfcurve(safeFiles{p}.all.class(testIndices),us4,1);
        fprintf('p:%d AUC kn%d: us1:%g \n',p,kn,u1);
        allu(kn)=u1;
    end
    plot(allu,'color',cols{p});hold on;
    scores{p} =[scores{p} u1];
    %figure;plot(X,Y)
end

