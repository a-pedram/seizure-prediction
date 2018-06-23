load './variables/myFeaturesP2.mat';
numOf0=0;numOf1=0;
for i=1:size(myFeatures,2)
    if myFeatures(i).Result ==1
        numOf1 =numOf1+1;
    else
        numOf0 = numOf0+1;
    end
end

onesFerq = zeros(numOf1,19,16);
zerosFerq = zeros(numOf0,19,16);
n0=0;n1=0;
for i=1:size(myFeatures,2)
    if myFeatures(i).Result ==1
        n1 =n1+1;
        for j=1:16
            if max(myFeatures(i).frequencies(j,:)) == 0
                continue;
            end
            onesFerq(n1,:,j)=myFeatures(i).frequencies(j,:)./max(myFeatures(i).frequencies(j,:));
        end
    else
        n0=n0+1;
        for j=1:16
            if max(myFeatures(i).frequencies(j,:)) == 0
                continue;
            end
            zerosFerq(n0,:,j)=myFeatures(i).frequencies(j,:)./max(myFeatures(i).frequencies(j,:));
        end
    end
end
E=3;
close all;
for E=9:16
o=mean(onesFerq(:,:,E))
std(onesFerq(:,:,E))
z=mean(zerosFerq(:,:,E))
std(zerosFerq(:,:,E))
figure; plot(z);
%figure; plot(o);
end