clear all;
close all;
readSafeFiles;
load 'd:/fImages.mat';
numOfTrain0 =[size(safeFiles{1}.all,1) size(safeFiles{2}.all,1) size(safeFiles{3}.all,1)];
numOfTests= [216 1002 690];
avgImages= cell(1,3);
mask =cell(3,1);
mask{1}=[ones(2,16)*.05; ones(14,16);ones(22,16)*.05]; mask{1}(:,1:4)=0;mask{1}(:,8:9)=0;mask{1}(:,11:12)=0;
mask{2}=[ones(16,16);ones(22,16)*.1];mask{2}(:,10:11)=0;mask{2}(:,6:7)=0;mask{2}(:,13:16)=0;
mask{3}=[ones(2,16)*.1;ones(1,16)*.9;ones(9,16)*1.15;ones(3,16)*.09;ones(14,16)*0;ones(2,16)*0.5;ones(7,16)*0];mask{3}(:,9:12)=0;mask{3}(:,14)=0;mask{3}(:,2:3)=0;
mask{3}(24:27,13:16)=.99;
mask{3}(24:27,1:4)=.05;
mask{3}(20:22,6:8)=.1;
for p=1:3
    disp(p);
    avgImages{p}.train0 =zeros(38,16);
    avgImages{p}.train1 =zeros(38,16);
    avgImages{p}.train =zeros(38,16);
    avgImages{p}.test =zeros(38,16);
    sumImage0=zeros(38,16);
    sumImage1=zeros(38,16);
    for i = 1:size(safeFiles{p}.zeros,1)
        sumImage0 = sumImage0 +fImages{p}.(['tr' safeFiles{p}.zeros.image{i}(1:end-4) ]);
    end
    avgImages{p}.train0 = sumImage0 /size(safeFiles{p}.zeros,1);
    for i = 1:size(safeFiles{p}.ones,1)
        sumImage1 = sumImage1 +fImages{p}.(['tr' safeFiles{p}.ones.image{i}(1:end-4) ]);
    end
    avgImages{p}.train1 = sumImage1 /size(safeFiles{p}.ones,1);
    avgImages{p}.train = (sumImage0 +sumImage1) /(numOfTrain0(p)+size(safeFiles{p}.ones,1));
    sumImage0=zeros(38,16);
    for i = 1:numOfTests(p)
        sumImage0 = sumImage0 +fImages{p}.(['tsnew_' num2str(p) '_' num2str(i)]);
    end
    avgImages{p}.test = sumImage0 /numOfTests(p);
    avgImages{p}.dTestTrain=avgImages{p}.test - avgImages{p}.train;
    avgImages{p}.Importance=abs(avgImages{p}.train1-avgImages{p}.train0);
end
save './variables/avgImages.mat' avgImages;

figure;
for p=1:3
    subplot(3,7,(p-1)*7+1);
    imshow(avgImages{p}.train0);
    title('train 0');
    subplot(3,7,(p-1)*7+2);
    imshow(avgImages{p}.train1);
    title('train 1');
    subplot(3,7,(p-1)*7+3);
    imshow(avgImages{p}.train);
    title('train');
    subplot(3,7,(p-1)*7+4);
    imshow(avgImages{p}.test);
    title('test');
    subplot(3,7,(p-1)*7+5);
    d=avgImages{p}.Importance;
    imshow(d,[min(min(d)) max(max(d))]);
    title(['importance ' num2str(min(min(d))) ' _ ' num2str(max(max(d)))]);
    subplot(3,7,(p-1)*7+6);
    d=abs(avgImages{p}.train1-avgImages{p}.train0+avgImages{p}.dTestTrain);
    imshow(abs(d),[min(min(d)) max(max(d))]);
    title(['XX' num2str(min(min(d))) ' _ ' num2str(max(max(d)))]);
    subplot(3,7,(p-1)*7+7);
    imshow(mask{p});
    title(sum(sum(mask{p})))
end

% normT0 = sqrt(sum(sum(avgImages{p}.train0)));
% normT1 = sqrt(sum(sum(avgImages{p}.train1)));
% scoresU= cell(1,3);
% scoresC= cell(1,3);
% for p=1:3
%     fprintf('wrinting down Patient:%d\n',p);     
%     scoresU{p}= zeros(numOfTests(p),1);
%     scoresC{p}= zeros(numOfTests(p),1);
%     for i = 1:numOfTests(p)
%         correctedImg = fImages{p}.(['ts' num2str(p) '_' num2str(i)]) - avgImages{p}.dTestTrain;
%         d1 =sqrt(sum(sum( (avgImages{p}.train1 - correctedImg).^2  )));
%         d0 =sqrt(sum(sum( (avgImages{p}.train0 - correctedImg).^2  )));                
%         scoresU{p}(i)= d0/(d1+d0);
%         
%         normCorrectImg=sqrt(sum(sum(correctedImg)));
%         cosD1 = sum(sum(correctedImg .* avgImages{p}.train1 ))./(normT1 * normCorrectImg);
%         cosD0 = sum(sum(correctedImg .* avgImages{p}.train0 ))./(normT0 * normCorrectImg);
%         scoresC{p}(i)=cosD1/(cosD0+cosD1);
%     end
% end
% for p=1:3    
%     scoresU{p}=(scoresU{p}-mean(scoresU{p})) ./ std(scoresU{p});
%     
%     scoresC{p}=(scoresC{p}-mean(scoresC{p})) ./ std(scoresC{p});
% end
% 
% fidU= fopen('d:\imgResultUcleadian.csv','w');
% fidC= fopen('d:\imgResultCosine.csv','w');
% fprintf(fidU,'File,Class\n');
% fprintf(fidC,'File,Class\n');
% for p=1:3
%     for i = 1:numOfTests(p)
%         fprintf(fidU,'%s,%g\n',[num2str(p) '_' num2str(i) '.mat'], scoresU{p}(i));
%         fprintf(fidC,'%s,%g\n',[num2str(p) '_' num2str(i) '.mat'], scoresC{p}(i));
%     end
% end
% fclose(fidU);
% fclose(fidC);


% normT0 = sqrt(sum(sum(avgImages{p}.train0)));
% normT1 = sqrt(sum(sum(avgImages{p}.train1)));
% scoresU= cell(1,3);
% scoresC= cell(1,3);
% d1 = zeros(1,150);
% cosD1 = zeros(1,150);
% for p=1:3
%     fprintf('wrinting down Patient:%d\n',p);
%     for i = 1:numOfTests(p)
%         correctedImg = fImages{p}.(['ts' num2str(p) '_' num2str(i)]) - avgImages{p}.dTestTrain;
%         for i1 = 1:150
%             d1(i1) = sqrt(sum(sum(correctedImg - fImages{p}.(['tr' num2str(p) '_' num2str(i1) '_1'])).^2));
%         end        
%         scoresU{p}(i)= mean(d1);
%         
%         normCorrectImg=sqrt(sum(sum(correctedImg)));
%         normS = normT1 * normCorrectImg;
%         for i1 = 1:150
%             cosD1(i1) = sum(sum(correctedImg .* fImages{p}.(['tr' num2str(p) '_' num2str(i1) '_1'])))./ normS;
%         end        
%         scoresC{p}(i)= mean(cosD1);  
%         fprintf('p:%d n:%d\n',p,i);
%     end
% end
% 
% for p=1:3    
%     scoresU{p}=(scoresU{p}-mean(scoresU{p})) ./ std(scoresU{p});
%     
%     scoresC{p}=(scoresC{p}-mean(scoresC{p})) ./ std(scoresC{p});
% end
% 
% 
% fidU= fopen('d:\imgResultUcleadian.csv','w');
% fidC= fopen('d:\imgResultCosine.csv','w');
% fprintf(fidU,'File,Class\n');
% fprintf(fidC,'File,Class\n');
% for p=1:3
%     for i = 1:numOfTests(p)
%         fprintf(fidU,'%s,%g\n',[num2str(p) '_' num2str(i) '.mat'], scoresU{p}(i));
%         fprintf(fidC,'%s,%g\n',[num2str(p) '_' num2str(i) '.mat'], scoresC{p}(i));
%     end
% end
% fclose(fidU);
% fclose(fidC);
