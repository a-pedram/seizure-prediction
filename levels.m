clc;
clear all;
close all;
load './variables/stdE.mat'
for p=1:3
    figure('units','normalized','outerposition',[0 0 1 1])
    for i=1:size(stdE{p},2)
        if stdE{p}(i).result==1
            if rem(i,3)~=2
                continue;
            end
            plot(stdE{p}(i).std,'Color','r')
             hold on;
            ylim([0 130])
           disp(i)
        else
            if rem(i,17)~=2
                continue;
            end
            plot(stdE{p}(i).std)%,'LineStyle','--')  
            ylim([0 130])
            hold on;
        end   
    end

end