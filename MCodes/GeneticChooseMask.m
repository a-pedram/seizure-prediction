readSafeFiles;
load 'd:/fImages.mat';
load './variables/avgImages.mat'
est=cell(3,1);
p=3


%intial first generation
pop = cell(100,1);
children = cell(50,1);
for c=1:100
    pop{c} = ones(38,16);
    y = randi(38,1,50);
    x = randi(16,1,50);
    for j=1:50
        pop{c}(y(j),x(j)) = 0;
    end
end
fitness = zeros(100,3);
for c=1:100   
    mask = pop{c};
    freqImgFitness;
    fitness(c,2) = AUC;
    fitness(c,1) = c;
end

for g=1:100
    mx = max(fitness(:,2));
    fprintf('genration:%d Max fitness:%g\n',g,mx);
    mn = min(fitness(:,2));
    fitness(:,3)= (fitness(:,2)-mn)/(mx - mn) +.1;
    fitness = sortrows(fitness,-2);
    % CORSS OVER -----------------------------
    pc =1;
    childN=1;
    while childN <= 50
        if fitness(pc,3) >rand()
            pa1 = fitness(pc,1);
            pc = pc+1;
            if pc >100
                pc=1;
            end
        end
        if fitness(pc,3) >rand()
            pa2 = fitness(pc,1);
            pc = pc+1;
            if pc >100
                pc=1;
            end
        end
        children{childN} = (pop{pa1}+pop{pa2})/2;
        childN=childN+1;
    end
    % MUTATION --------------------------------------
    mutants = randi(50,1,20);
    for i=1:20
        row =randi(38);
        col =randi(16);
        row2 = row + 2;
        if row2>38
            row2=38;
        end
        children{mutants(i)}(row:row2,col) = 1 - children{mutants(i)}(row:row2,col); 
    end
    for c=1:50   
        mask = children{c};
        pop{fitness(c+50,1)}=children{c};
        freqImgFitness;
        fitness(c+50,2) = AUC;
        fitness(c+50,1) = fitness(c+50,1);
    end    
    
end
