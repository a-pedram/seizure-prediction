function y= myResample(x,n)
sx=size(x,1);
y= zeros(ceil(sx/n),1);
sy=size(y,1);
for i=1:sy
    y(i)=sum(x((i-1)*n+1:i*n))./n;
end
end