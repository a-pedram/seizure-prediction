function [scores,pop]= pairScore(wl,patient,E1,E2)
p=patient;
global datasetLetterWinL;

pLetters = datasetLetterWinL{wl}{p};
tuples1= zeros(650,650);
tuples0= zeros(650,650);
tuples1F= zeros(650,650);
tuples0F= zeros(650,650);
fileFlag0=zeros(650,650);
fileFlag1=zeros(650,650);
for fn=1:size(pLetters,1)
    numOfLetters= size(pLetters{fn}.data,1)-2;        
    for l =1:numOfLetters
        l1=pLetters{fn}.data(l,E1);
        l2=pLetters{fn}.data(l,E2);
        if pLetters{fn}.result==1
            tuples1(l1,l2)=tuples1(l1,l2)+1;
            if fileFlag1(l1,l2)~=fn
                fileFlag1(l1,l2)=fn;
                tuples1F(l1,l2)=tuples1F(l1,l2)+1;
            end
        else
            tuples0(l1,l2)=tuples0(l1,l2)+1;
            if fileFlag0(l1,l2)~=fn
                fileFlag0(l1,l2)=fn;
                tuples0F(l1,l2)=tuples0F(l1,l2)+1;
            end
        end
    end
end
%     tt= tuples1 ./ (tuples0+tuples1);
%     tt(isnan(tt))=0;
pop = tuples1F+tuples0F;
scores= tuples1F ./ (tuples0F+tuples1F);
scores(isnan(scores))=0;
end