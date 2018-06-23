
answers =cell(3,1);
for p=1:3

clusters = cell(16,1);
allSamples= zeros(size(myFeatures{p},2),19,16);

for i=1:size(myFeatures{p},2)    
    for j=1:16
        if max(myFeatures{p}{i}.frequencies(j,:)) == 0
            allSamples(i,:,j)= zeros(1,19);
            continue;
        end
        allSamples(i,:,j)=myFeatures{p}{i}.frequencies(j,:)./max(myFeatures{p}{i}.frequencies(j,:));
    end
end

sa=size(allSamples,1);
inds= randperm(sa);
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
        if dMin>0.6
            nc(E)=nc(E)+1;
            clusters{E}(nc(E),:)=sample;
        else
            clusters{E}(minC,:)=(clusters{E}(minC,:) * nu(minC) + sample)/(nu(minC)+1);
            nu(minC)=nu(minC)+1;
        end
    end
    % delete sparse clusters
    for j=nc(E):-1:1
        if nu(j)<3
            clusters{E}(j,:)=[];
            nc(E)=nc(E)-1;
        end
    end
end
%refine clusters :
% for E=1:16
%     nu= zeros(100,1);    
%     for i=1:sa
%         dMin=99;
%         sample= allSamples(inds(i),:,E);
%         for j=1:nc(E)
%             d = sqrt(sum((clusters{E}(j,:)-sample).^2));
%             if d<dMin
%                 dMin=d;
%                 minC=j;
%             end
%         end
%         clusters{E}(minC,:)=(clusters{E}(minC,:) * nu(minC) + sample)/(nu(minC)+1);
%         nu(minC)=nu(minC)+1;
%     end
% end

answers{p}=zeros(size(myFeatures{p},2),17);
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
        answers{p}(inds(i),E)=minC;
        answers{p}(inds(i),17)=myFeatures{p}{inds(i)}.Result;        
    end
    
end
%sAns = sortrows(answers,17);
fFile = ['.\variables\clustersP' num2str(p) '.mat'];
save(fFile, 'clusters');
end
save( '.\variables\answersID3Freq.mat','answers');
