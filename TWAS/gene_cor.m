function [cardres,flankres,listres,bmires]=gene_cor(File1,File2,File3,File4,File5,File6,File7)

[cardres]=prediction(File1,File2,File3,File4);
[flankres]=prediction(File1,File5,File3,File4);
[listres]=prediction(File1,File6,File3,File4);
[bmires]=prediction(File1,File7,File3,File4);
% [sst,sstgene]=prediction(File1,File8,File3,File4);

cb=card.Var4;
fb=flank.Var4;
lb=list.Var4;
nb=bmi.Var4;
% sb=sst.Var6;


cTF=isoutlier(cb,"mean");
lTF=isoutlier(lb,"mean");
fTF=isoutlier(fb,"mean");
nTF=isoutlier(nb,"mean");
% sTF=isoutlier(sb,"mean");
cTF=find(cTF==1);
fTF=find(fTF==1);
lTF=find(lTF==1);
nTF=find(nTF==1);
% sTF=find(sTF==1);
index=union(cTF,fTF);
index=union(index,lTF);
index=union(index,nTF);
% index=union(index,sTF);
cb(index,:)=[];
fb(index,:)=[];
lb(index,:)=[];
% sb(index,:)=[];
nb(index,:)=[];


[gene_corr_lc,p_lc]=corr(cb,lb);
[gene_corr_lf,p_lf]=corr(lb,fb);
[gene_corr_cf,p_cf]=corr(cb,fb);
[gene_corr_cn,p_cn]=corr(cb,nb);
% [gene_corr_cs,p_cs]=corr(cb,sb);
[gene_corr_fn,p_fn]=corr(fb,nb);
% [gene_corr_fs,p_fs]=corr(fb,sb);
[gene_corr_ln,p_ln]=corr(lb,nb);
% [gene_corr_ls,p_ls]=corr(lb,sb);
% [gene_corr_sn,p_sn]=corr(nb,sb);

result=zeros;
result(1,1)=gene_corr_lc;
result(1,2)=p_lc;
result(2,1)=gene_corr_lf;
result(2,2)=p_lf;
result(3,1)=gene_corr_cf;
result(3,2)=p_cf;
result(4,1)=gene_corr_cn;
result(4,2)=p_cn;
% result(5,1)=gene_corr_cs;
% result(5,2)=p_cs;
result(6,1)=gene_corr_fn;
result(6,2)=p_fn;
% result(7,1)=gene_corr_fs;
% result(7,2)=p_fs;
result(8,1)=gene_corr_ln;
result(8,2)=p_ln;
% result(9,1)=gene_corr_ls;
% result(9,2)=p_ls;
% result(10,1)=gene_corr_sn;
% result(10,2)=p_sn;

writematrix(result,File1+"_result","Delimiter",'tab',"FileType","text");

end



