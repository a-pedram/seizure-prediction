function [trainIdx,valIdx] = crossValidation(p)

if p==1
    %570/6 =95  95 * .5 =48
    i1= randperm(95);
    for i=1:48
        for j=1:6
            trainIdx((i-1)*6+j)=(i1(i)-1)*6+j;
        end
    end
    for i=49:95
        for j=1:6
            valIdx((i-49)*6+j)=(i1(i)-1)*6+j;
        end
    end
    i2= randperm(25);
    %25*.5=13
    for i=1:13
        for j=1:6
            trainIdx2((i-1)*6+j)=(i2(i)-1)*6+j+570;
        end
    end
    for i=14:25
        for j=1:6
            valIdx2((i-14)*6+j)=(i2(i)-1)*6+j+570;
        end
    end    
    trainIdx=[trainIdx trainIdx2];
    valIdx=[valIdx valIdx2];
    rm =826-720;
    i2=randperm(rm);
    trainIdx=[trainIdx  720+i2(1:floor(.5*rm))];
    valIdx=[valIdx  720+i2(floor(.5*rm)+1:end)];
end
if p==2
    %1836/6 =306  306 * .5 =153
    i1= randperm(306);
    for i=1:153
        for j=1:6
            trainIdx((i-1)*6+j)=(i1(i)-1)*6+j;
        end
    end
    for i=154:306
        for j=1:6
            valIdx((i-154)*6+j)=(i1(i)-1)*6+j;
        end
    end
    i2= randperm(25);
    %25*.5=13
    for i=1:13
        for j=1:6
            trainIdx2((i-1)*6+j)=(i2(i)-1)*6+j+1836;
        end
    end
    for i=14:25
        for j=1:6
            valIdx2((i-14)*6+j)=(i2(i)-1)*6+j+1836;
        end
    end    
    trainIdx=[trainIdx trainIdx2];
    valIdx=[valIdx valIdx2];
    rm =2058-1986;
    i2=randperm(rm);
    trainIdx=[trainIdx  1986+i2(1:floor(.5*rm))];
    valIdx=[valIdx  1986+i2(floor(.5*rm)+1:end)];
end
if p==3
    %1908/6 =318  318 * .5 =159
    i1= randperm(318);
    for i=1:159
        for j=1:6
            trainIdx((i-1)*6+j)=(i1(i)-1)*6+j;
        end
    end
    for i=160:318
        for j=1:6
            valIdx((i-160)*6+j)=(i1(i)-1)*6+j;
        end
    end
    i2= randperm(25);
    %25*.5=13
    for i=1:13
        for j=1:6
            trainIdx2((i-1)*6+j)=(i2(i)-1)*6+j+1908;
        end
    end
    for i=14:25
        for j=1:6
            valIdx2((i-14)*6+j)=(i2(i)-1)*6+j+1908;
        end
    end    
    trainIdx=[trainIdx trainIdx2];
    valIdx=[valIdx valIdx2];
    rm =2163-2058;
    i2=randperm(rm);
    trainIdx=[trainIdx  2058+i2(1:floor(.5*rm))];
    valIdx=[valIdx  2058+i2(floor(.5*rm)+1:end)];
end
end