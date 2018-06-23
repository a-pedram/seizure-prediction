readSafeFiles; 
 jump=10000;
 avgs = zeros(240000/jump,16);
 stds = zeros(240000/jump,16);
 
for p=1:3
figure;
for j =1:12
    load(['d:/kaggle/seizure/train_' num2str(p) '/' safeFiles{p}.zeros.image{j*10}]);
  for i=1:jump:240000-jump
     avgs(((i-1)/jump)+1,:)=mean((dataStruct.data(i:i+jump,:)).^3);
     stds(((i-1)/jump)+1,:)=std(dataStruct.data(i:i+jump,:));
 end
 c = corr(avgs);
 s = corr(stds);
for i=1:16
    c(i,i)=0;
    %s(i,i)=0;
end
subplot(4,12,j);imshow(c);title(sum(c(:)));
subplot(4,12,j+12);imshow(s);title(sum(s(:)));
end

for j =1:12
    load(['d:/kaggle/seizure/train_' num2str(p) '/' safeFiles{p}.ones.image{j*10}]);
  for i=1:jump:240000-jump
     avgs(((i-1)/jump)+1,:)=mean((dataStruct.data(i:i+jump,:)).^3);
     stds(((i-1)/jump)+1,:)=std(dataStruct.data(i:i+jump,:));
 end
 c = corr(avgs);
 s = corr(stds);
for i=1:16
    c(i,i)=0;
    %s(i,i)=0;
end
subplot(4,12,24+j);imshow(c);title(sum(c(:)));
subplot(4,12,36+j);imshow(s);title(sum(s(:)));
end
end