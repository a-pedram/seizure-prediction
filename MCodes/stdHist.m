function h= stdHist(data)
h=zeros(1,14);
s= std(data);
h(1)= sum(data >= 3*s);
h(2)= sum(data < 3*s   & data >= 5*s/2);
h(3)= sum(data < 5*s/2 & data >= 2*s );
h(4)= sum(data < 2*s   & data >= 3*s/2);
h(5)= sum(data < 3*s/2 & data >= s );
h(6)= sum(data < s     & data >=  s/2);
h(7)= sum(data < s/2   & data >= 0);
h(14)= sum(data <= -3*s);
h(13)= sum(data > -3*s   & data <= -5*s/2);
h(12)= sum(data > -5*s/2 & data <= -2*s );
h(11)= sum(data > -2*s   & data <= -3*s/2);
h(10)= sum(data > -3*s/2 & data <= -s );
h(9)=  sum(data > -s     & data <= -s/2);
h(8)=  sum(data > -s/2    & data <= 0);
end