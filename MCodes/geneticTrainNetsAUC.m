function [nets,err] = geneticTrainNetsAUC(input,targets,nGeneration,pop,nLayer1,nLayer2,valData,valTarget,nets)
%input =irisInputs';targets=irisInputs(:,trIds)';pop=1000;nGeneration=1000;nLayer1= 4; nLayer2=   3;

netErrors = ones(pop*2,2)*9999999;
netErrors(:,1) = 1:pop*2;
fSize = size(input,2);
if nargin==7
    startInit= size(nets,2)+1;
    nets{pop*2}=[];
else
    startInit=1;
    nets=cell(1,pop*2);
end
for i=startInit:pop*2
    nets{i}=createNet(fSize,nLayer1,nLayer2);
end
for i=1:pop*2    
    netOuts=netOutput(nets{netErrors(i,1)},input);  
    netErrors(i,2)=mean((targets - netOuts).^2); 
end
netErrors = sortrows(netErrors,-2);
auVal=0
for g=1:nGeneration

maxError = min(netErrors(:,2));
minError = max(netErrors(:,2));
fprintf('G:%d minMSE:%g \n',g,minError);

%cross Over:
childN=0;
pc=1;
while childN <pop
    pa1=0;
    while pa1==0
        if (maxError - netErrors(pc,2))/(maxError-minError)+ .2 * (rand()-.5)> rand()
            pa1 = netErrors(pc,1);
            pc=pc+1;
            if pc > pop
                pc=1;
            end
        end
    end
    pa2=0;
    while pa2==0
        if (maxError - netErrors(pc,2))/(maxError-minError)+ .2 * (rand()-.5) > rand()
            pa2 = netErrors(pc,1);
            pc=pc+1;
            if pc > pop
                pc=1;
            end
        end
    end
    %perception :
    childN=childN+1;
    place= netErrors(pop+childN,1);
    if rand()>.5        
        for l=1:3
            nets{place}{l}=(nets{pa1}{l}+nets{pa2}{l})/2;
        end
    else
        for l=1:3
            for n=1:size(nets{place}{l},2)
                if rand()>.5
                    nets{place}{l}(:,n)=nets{pa1}{l}(:,n);
                else
                    nets{place}{l}(:,n)=nets{pa2}{l}(:,n);
                end            
            end
        end
    end
    %mutation:
    if rand()>.75
        for l=1:3
            if rand()> .5
                nuId = randi(size(nets{place}{l},2));
                wId = randi(size(nets{place}{l},1));
                nets{place}{l}(wId,nuId)=nets{place}{l}(wId,nuId) + (rand()-.5)*.5;
            end
        end
    end    
end
for i=pop+1:pop*2    
    netOuts=netOutput(nets{netErrors(i,1)},input);   
    netErrors(i,2)=AUC( netOuts, targets );        
end
netErrors = sortrows(netErrors,-2);
if rem(g,50)==0  % STOP OVER FITTING
    netOuts2=netOutput(nets{netErrors(1,1)},valData);   
    au=AUC( netOuts2, valTarget );
    if au+.1 > auVal
        auVal = au;
    else 
        fprintf('learning was stop at generation:%d to prevent overfitting!\n',g);
        break;
    end
end
 a=get(0,'PointerLocation');
 if a(1)==1920 && a(2)==1080
     break;
 end
end
netErrors = sortrows(netErrors,-2);
nets=nets(netErrors(1:pop,1));
err=netErrors(1:pop,2);
end