function [generes]=prediction(x,y,z,sub)
fprintf('handling %s and %s\n',x,y);
% x='mashr_Brain_Anterior_cingulate_cortex_BA24__predict.txt';
% y='card.txt';
% z='mashr_Brain_Anterior_cingulate_cortex_BA24__summary.txt';
% sub='sub.xlsx';
sub=readtable(sub);
sub=table2cell(sub);
transdata = readtable(x,'VariableNamingRule','preserve');
transub = transdata.IID;
Behav = readtable(y);
Behav=table2cell(Behav);
Behavsub = Behav(:,2);

results = cellfun(@(x) strsplit(x, '_'), transub,'UniformOutput', false);
unitransub = cellfun(@(x) ['NDAR_' x{end}], results, 'UniformOutput', false);

[~,ia,ib] = intersect(Behavsub,unitransub);
Behavsub=Behavsub(ia,:);

Behav=Behav(ia,:);
Behavscores = Behav(:,3);
agescores = Behav(:,4);
sex=Behav(:,5);

% sex_1=find(ismember(sex,'F'));
% sex_2=find(ismember(sex,'M'));
% sex=zeros;
% sex(sex_1)=0;
% sex(sex_2)=1;
% sex=sex';
Behavscores=cell2mat(Behavscores);
agescores=cell2mat(agescores);
sex=cell2mat(sex);
%overlapBehavsub = Behav.textdata(ia);
overlaptransdata = transdata(ib,:);
%overlaptrasub = unitransub(ib);

[~,ic,~]=intersect(Behavsub,sub);
Behavscores=Behavscores(ic);
agescores=agescores(ic);
sex=sex(ic);
overlaptransdata=overlaptransdata(ic,:);
NanSubidx = find(Behavscores==-9);
Behavscores(NanSubidx)=[];
agescores(NanSubidx)=[];
sex(NanSubidx)=[];
overlaptransdata(NanSubidx,:)=[];
WidthNum=width(overlaptransdata);
res={};
for i = 3:WidthNum
    data1 = overlaptransdata(:,i);
    data1=table2array(data1);
    %控制掉性别与年龄，把年龄加到行为变量里去
    %[r,p]=corr(data1,Behavscores);
    %res(i-2,1)=r;
    %res(i-2,2)=p;
    [b,~]=regress(Behavscores,[data1,agescores,sex,ones(length(data1),1)]);
    [~,pp]=partialcorr([Behavscores,data1,agescores,sex]);
    res(i-2,1)=num2cell(b(1));
    res(i-2,2)=overlaptransdata.Properties.VariableNames(i);
    stdb=b(1)*std(data1)/std(Behavscores);
    res(i-2,3)=num2cell(stdb);
    res(i-2,4)=num2cell(pp(1,2));
end
tmp = readtable(z);
[~,c1,c2]=intersect(tmp.gene,res(:,2));
gene_name=tmp(c1,"gene_name");
res=res(c2,:);
generes=horzcat(gene_name,res);
%把有用的gene取出来放到res里去
gene={};
for i = 1: (WidthNum-2)
    if(generes.Var5(i)<0.05/WidthNum)
        gene(i,:)=table2cell(generes(i,:));
    end
end
emptyCells = cellfun(@isempty, gene);
rowsWithEmpty = any(emptyCells, 2);
gene(rowsWithEmpty, :) = [];
out=erase(x,'_predict.txt');
out=[out,y];
writecell(gene,out,"Delimiter",'tab');
end