clear  all;
load 'd:/lettersWinL.mat';

wl=12;
p=1;
E=8;

smin=0;
letterNeighbors = cell(16,1);
for wl=16:-1:6
    wl
    for p=1:3
        for E=1:16
            letters =lettrsWinL{wl}{p,E};
            for i=1:size(letters,2);
                minD=9999;
                for j=1:size(letters,2);
                    if i==j
                        continue;
                    else
                        d= sqrt(sum((letters(:,i)- letters(:,j)).^2));
                        if d<minD
                            minD=d;
                            minJ=j;                            
                        end
                    end
                end
                letterNeighbors{wl}{p}{E}(i)=minJ;                
                %fprintf('%d: %d %g \n',i,minJ,minD);
            end
        end
    end
end
save './variables/letterNeighbors.mat' letterNeighbors;