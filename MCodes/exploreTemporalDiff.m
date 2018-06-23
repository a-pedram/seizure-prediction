close all;
clear all;
clc;
j=0;
for i=1:150
    j=j+1;
    load(['d:/kaggle/seizure/train_2/2_' num2str(i) '_0.mat']);
    frq1 = myFrequencies(dataStruct.data(1:40000,1),400,3);
    %figure;plot(frq1);
    frq2 = myFrequencies(dataStruct.data(200000:240000,1),400,3);
    %figure;plot(frq2);
    %figure;plot(frq2-frq1);%ylim([-0.5 0.5]);
    d=frq2-frq1;
    s12= sum(d);
    s22= sum(abs(d));
    dabs2 = abs(s12)-abs(s22);
    anss(j,1)=0;
    md(j,:) = d;
    mdabs(j,:)= abs(d);
    %fprintf('0: %g\tabs:%g\tdabs:%g \n', s1,s2,dabs);
    load (['d:/kaggle/seizure/train_2/2_' num2str(i) '_1.mat']);
    frq1 = myFrequencies(dataStruct.data(1:40000,1),400,3);
    %figure;plot(frq1);
    frq2 = myFrequencies(dataStruct.data(200000:240000,1),400,3);
    %figure;plot(frq2);
    %figure;plot(frq2-frq1);%ylim([-0.5 0.5]);
    d=frq2-frq1;
    s1= sum(d);
    s2= sum(abs(d));
    dabs = abs(s2)-abs(s1);
    j=j+1;
    anss(j,1)=1;
    md(j,:) = d;
    mdabs(j,:)= abs(d);
    fprintf('%d: %g\t%g\tabs:%g\t%g\tdabs:%g\t%g \n',i,s12, s1,s22,s2,dabs2,dabs);
    %fprintf('-----------------------\n');
end
for k=1:17
cv =cov(anss,md(:,k)) /(std(anss)*std(md(:,k)));
cv2 =cov(anss,mdabs(:,k)) /(std(anss)*std(mdabs(:,k)));
cv3 =cov(anss,mdabs(:,k)+mdabs(:,k+1)+mdabs(:,k+3)) /(std(anss)*std((mdabs(:,k)+mdabs(:,k+1)+mdabs(:,k+3))));
fprintf('ch:%d %g\t%g\t%g\n',k,cv(1,2),cv2(1,2),cv3(1,2));
end
