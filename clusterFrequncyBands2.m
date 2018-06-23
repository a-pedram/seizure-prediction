
answers =cell(3,1);
for p=1:3

clusters = cell(19,1);
allSamples= zeros(size(myFeatures{p},2),16,19);
sam = zeros(16,19);
for i=1:size(myFeatures{p},2)    
    for j=1:16
        if max(myFeatures{p}{i}.frequencies(j,:)) == 0
            allSamples(i,j,:)= zeros(19,1);
            continue;
        end
        sam(j,:) = myFeatures{p}{i}.frequencies(j,:)./max(myFeatures{p}{i}.frequencies(j,:));        
    end
    allSamples(i,:,:)=sam;
end

sa=size(allSamples,1);
inds= randperm(sa);
nc=zeros(19,1);
for F=1:19
    clusters{F}=[];
    nu= zeros(100,1);    
    for i=1:sa
        dMin=99;
        sample= allSamples(inds(i),:,F);
        for j=1:nc(F)
            d = sqrt(sum((clusters{F}(j,:)-sample).^2));
            if d<dMin
                dMin=d;
                minC=j;
            end
        end
        if dMin>.8
            nc(F)=nc(F)+1;
            clusters{F}(nc(F),:)=sample;
        else
            clusters{F}(minC,:)=(clusters{F}(minC,:) * nu(minC) + sample)/(nu(minC)+1);
            nu(minC)=nu(minC)+1;
        end
    end
    % delete sparse clusters
    for j=nc(F):-1:1
        if nu(j)<3
            clusters{F}(j,:)=[];
            nc(F)=nc(F)-1;
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

answers{p}=zeros(size(myFeatures{p},2),20);
for F=1:19
    for i=1:sa
        dMin=99;
        sample= allSamples(inds(i),:,F);
        for j=1:nc(F)
            d = sqrt(sum((clusters{F}(j,:)-sample).^2));
            if d<dMin
                dMin=d;
                minC=j;
            end
        end
        answers{p}(inds(i),F)=minC;
        answers{p}(inds(i),20)=myFeatures{p}{inds(i)}.Result;        
    end
    
end
%sAns = sortrows(answers,17);
fFile = ['.\variables\clustersP' num2str(p) '.mat'];
save(fFile, 'clusters');
%answers{p}=answers{p}';
end
save( '.\variables\answersID3Freq.mat','answers');
