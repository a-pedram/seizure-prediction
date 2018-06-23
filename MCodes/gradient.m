close all;
for j=1:16
    fName=[ '1_' num2str(j*6) '_1.mat'];
path =['d:/kaggle/seizure/train_1/' fName];
load(path)

    c1 = dataStruct.data(:,8);
    dc = c1(2:end)- c1(1:end-1);
    dc = (20 /pi)*atan( dc );
    
    %dc=dc/3;
    x= floor(min(dc)) : ceil(max(dc));
    y= zeros(size(x));
    minDC=floor( min(dc));
    for i=1:size(dc,1)
        indx = round(dc(i))-minDC+1;
        y(indx) = y(indx)+1;
    end
    zp= -minDC+1;
    d=10;
    figure;bar(x(zp-d:zp+d),y(zp-d:zp+d));
    %ylim([0 150000])
end