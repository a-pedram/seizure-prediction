clear all;
patientParams=cell(3,1);
 wls=[16 15 13 16 15 14 15 15 15 14 13 ];
 is= [7  7  4  4  2  12 7  2  2  9  5  ];
 js= [16 11 16 16 6  15 13 10 13 12 9  ];
patientParams{1}.wls =wls;
patientParams{1}.is = is;
patientParams{1}.js = js;

 wls=[10 12 10 14 14 14 12 11 ];
 is= [5  12 12 12 3  5  14 3 ];
 js= [12 16 14 15 14 12 16 5 ];
patientParams{2}.wls =wls;
patientParams{2}.is = is;
patientParams{2}.js = js;

wls=[13 10 12 13 8 6  11 ];
is= [11 6  7  6  2 6  1  ];
js= [16 11 8  8  6 13 8  ];
patientParams{3}.wls =wls;
patientParams{3}.is = is;
patientParams{3}.js = js;


global datasetLetterWinL;
load 'd:\datasetLettersWinL.mat';
trainScores=cell(3);
for p=1:3
    fprintf('Training for patint:%d\n',p);
    trainScores{p} = cell(size(patientParams{p}.wls,2),1);
    for par=1:size(patientParams{p}.wls,2)
        [trainScores{p}{par}.scores, trainScores{p}{par}.counts]= ...
                pairScore(patientParams{p}.wls(par),p,patientParams{p}.is(par),patientParams{p}.js(par));
    end
end
fprintf('End Of training! Please wait to load the test dataset\n');
clear datasetLetterWinL;
load 'd:\testDatasetLettersWinL.mat';
load '.\variables\letterNeighbors.mat';
AllFileNames=cell(1);
AllScores=[];
for p=1:3
    fprintf('producing Results for patient:%d\n',p);
    SScores = zeros(3000 ,size(patientParams{p}.wls,2));
    scores=zeros(3000,1);
    filenames=cell(3000,1);
    for par=1:size(patientParams{p}.wls,2)
        pLetters = datasetLetterWinL{patientParams{p}.wls(par)}{p};
        fnn=0;
        for fn=1:size(pLetters,1) 
            numOfLetters= size(pLetters{fn}.data,1)-2;
            sq=0;
            score=0;
            E1 = patientParams{p}.is(par);
            E2 = patientParams{p}.js(par);
            usedPairs = zeros(490000,1);
            for l =1:numOfLetters
                l1=pLetters{fn}.data(l,E1);
                l12 = letterNeighbors{patientParams{p}.wls(par)}{p}{E1}(l1);
                l2=pLetters{fn}.data(l,E2);
                l22 = letterNeighbors{patientParams{p}.wls(par)}{p}{E2}(l2);
                if usedPairs(l1*700+l2) == 1
                    disp('sdfsdfsdfsfa')
                    continue;
                end
                usedPairs(l1*700+l2) =1;
                sq = sq+trainScores{p}{par}.counts(l1,l2)^.33;% log(tuples1F(l1,l2)+1);
                sq = sq+trainScores{p}{par}.counts(l1,l22)^.33;
                sq = sq+trainScores{p}{par}.counts(l12,l22)^.33;
                sq = sq+trainScores{p}{par}.counts(l12,l2)^.33;
                score = score + trainScores{p}{par}.scores(l1,l2) * trainScores{p}{par}.counts(l1,l2)^.33;%(log(tuples1F(l1,l2)+1));
                score = score + trainScores{p}{par}.scores(l1,l22) * trainScores{p}{par}.counts(l1,l22)^.33;
                score = score + trainScores{p}{par}.scores(l12,l22) * trainScores{p}{par}.counts(l12,l22)^.33;
                score = score + trainScores{p}{par}.scores(l12,l2)* trainScores{p}{par}.counts(l12,l2)^.33;
            end
            fnn=fnn+1;
            scores(fnn)=score/sq;
            if isnan( scores(fnn))
                fprintf('%g\n', sq);
                scores(fnn)=0;
            end
            filenames{fnn}=pLetters{fn}.fileName;
            %fprintf('fn:%d file:%s,score:%g \n',fn,pLetters{fn}.fileName ,scores(fn));
        end
        SScores(fnn+1:end,:)=[];
        scores=scores(1:fnn);
        filenames=filenames(1:fnn);        
        SScores(:,par) = scores;
    end
    AllFileNames=[AllFileNames;filenames];
    SScores = sum(SScores,2) / par;
    AllScores=[AllScores;SScores];
    
end   
fprintf('writing down the Results!\n');
fid= fopen('d:\result.csv','w');
fprintf(fid,'File,Class\n');
for i=1:size(AllScores,1)
    fprintf(fid,'%s,%g\n',AllFileNames{i+1},AllScores(i));
end
fclose(fid);