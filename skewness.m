close all;
figure;
c0=0; c1=0;
for i=3:6:300
    load (['e:/kaggle/seizure/train_1/1_' num2str(i) '_0.mat']);
    data = dataStruct.data(2:end,:)-dataStruct.data(1:end-1,:);
    N=size(data,1);
    data = data.^4 ;
    skew1=sum(data)./ 2400000 ;
    skew2=sum(data(180000:end,:))./ 60000 ;
    plot(skew1);hold on;
     c0 = c0+1;
     ss0(c0)=sum(skew2-skew1);
    ssa0(c0)=sum(abs(skew2-skew1));
    if i>150
        continue
    end
    load (['e:/kaggle/seizure/train_1/1_' num2str(i) '_1.mat']);
    data = dataStruct.data(2:end,:)-dataStruct.data(1:end-1,:);
    N=size(data,1);
    data = data.^4 ;
    skew1=sum(data)./ 2400000 ;
    skew2=sum(data(180000:end,:))./ 60000 ;
    plot(skew1,'Color','r');hold on;
     c1 = c1+1;
     ss1(c1)=sum(skew2-skew1);
     ssa1(c1)=sum(abs(skew2-skew1));
end

figure; 
subplot(2,1,1);
plot(ss0);hold on; plot(ss1,'Color','r');hold on;
plot(zeros(1,50),'Color','black');hold on;
% plot(ones(1,50)*-2400,'Color','black');hold on;

subplot(2,1,2);
plot(ssa0);hold on; plot(ssa1,'Color','r');