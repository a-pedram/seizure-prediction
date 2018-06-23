

for p=1:3
    fFile = ['.\variables\myFeaturesP' num2str(p) '.mat'];
load(fFile);
clusters = cell(16,1);
allSamples= zeros(size(myFeatures,2),19,17);

for i=1:size(myFeatures,2)    
    for j=1:16
        if max(myFeatures(i).frequencies(j,:)) == 0
            allSamples(i,:,j)= zeros(1,19);
            continue;
        end
        allSamples(i,:,j)=myFeatures(i).frequencies(j,:)./max(myFeatures(i).frequencies(j,:));
        allSamples(i,19,j)=myFeatures(i).Result;
    end
end

sa=size(allSamples,1);
inds= randperm(sa);
E=13;
nc=zeros(16,1);
for E=1:16
    clusters{E}=[];
    nu= zeros(100,1);    
    for i=1:sa
        dMin=99;
        sample= allSamples(inds(i),:,E);
        for j=1:nc(E)
            d = sqrt(sum((clusters{E}(j,:)-sample).^2));
            if d<dMin
                dMin=d;
                minC=j;
            end
        end
        if dMin>0.63
            nc(E)=nc(E)+1;
            clusters{E}(nc(E),:)=sample;
        else
            clusters{E}(minC,:)=(clusters{E}(minC,:) * nu(minC) + sample)/(nu(minC)+1);
            nu(minC)=nu(minC)+1;
        end
    end
    % delete sparse clusters
    for j=nc(E):-1:1
        if nu(j)<5
            clusters{E}(j,:)=[];
            nc(E)=nc(E)-1;
        end
    end
end
answers=zeros(size(myFeatures,2),17);
for E=1:16
    for i=1:sa
        dMin=99;
        sample= allSamples(inds(i),:,E);
        for j=1:nc(E)
            d = sqrt(sum((clusters{E}(j,:)-sample).^2));
            if d<dMin
                dMin=d;
                minC=j;
            end
        end
        answers(inds(i),E)=minC;
        answers(inds(i),17)=myFeatures(inds(i)).Result;        
    end
    
end
%sAns = sortrows(answers,17);
fFile = ['.\variables\clustersP' num2str(p) '.mat'];
save(fFile, 'clusters');
fFile = ['.\variables\answersP' num2str(p) '.mat'];
save( fFile,'answers');
end
% for i=1: nc
%     figure; plot(clusters{8}(i,:));
% end