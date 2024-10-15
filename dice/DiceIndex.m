function [index,p,shamp] = DiceIndex(data1,data2,alllength)
%UNTITLED3 此处提供此函数的摘要
%   此处提供详细说明

intersectdata = intersect(data1,data2);
index = 2*length(intersectdata)/(length(data1)+length(data2));
shamp=zeros;
shamp(1)=index;
for i = 1 :9999
shamdata1 = randi(alllength,length(data1),1);
shamdata2 = randi(alllength,length(data2),1);
shamintersectdata = intersect(shamdata1,shamdata2);
shamindex = 2*length(shamintersectdata)/(length(data1)+length(data2));
shamp(i+1) = shamindex;
end
shamp = sort(shamp,"descend");
tmp = find(shamp==index);
p = tmp(1)/10000;
%[yy1,xx1]=ksdensity(shamp);
%pic=plot(xx1,yy1);
end