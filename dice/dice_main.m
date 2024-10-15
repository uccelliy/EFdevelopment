clear;
clc;
card=load("card_smrigenic_feature.mat");
flank=load("flank_smri_feature.mat");
list=load("list_smri_feature.mat");

N=646;
[index_cf,p_cf,shamp_cf]=DiceIndex(card.all,flank.all,N);
% hold;
% dice_cf=plot(index_cf,0,"*");

[index_lf,p_lf,shamp_lf]=DiceIndex(list.all,flank.all,N);
% hold;
% dice_lf=plot(index_lf,0,"*");

[index_cl,p_cl,shamp_cl]=DiceIndex(card.all,list.all,N);
% dice_cl=plot(index_cl,0,"*");

pic_cf.Color=[0,0.45,0.74];
dice_cf.Color=[0,0.45,0.74];
dice_cf.MarkerSize=10;
pic_cl.Color=[0.47,0.67,0.19];
dice_cl.Color=[0.47,0.67,0.19];
dice_cl.MarkerSize=10;
pic_lf.Color=[0.93,0.69,0.13];
dice_lf.Color=[0.93,0.69,0.13];
dice_lf.MarkerSize=10;
legend('List with Flanker 4years later','List Flanker dice');
legend('Card with Flanker','Card Flanker Dice','List with Flanker','List Flanker Dice','Card with List','Card List Dice');
pic_lf.Parent.Title.String='SMRI';
pic_lf.Parent.Parent.Color=[1,1,1];
pic_lf.Parent.Box=false;
print(pic_lf.Parent.Parent,'./SMRI4yearslater.jpg','-r1200','-djpeg');


% [index_cn,p_cn,pic_cn]=DiceIndex(card.all,nback.all,N);
% [index_cs,p_cs,pic_cs]=DiceIndex(card.all,sst.all,N);
% [index_fn,p_fn,pic_fn]=DiceIndex(flank.all,nback.all,N);
% [index_fs,p_fs,pic_fs]=DiceIndex(flank.all,sst.all,N);
% [index_ln,p_ln,pic_ln]=DiceIndex(list.all,nback.all,N);
% [index_ls,p_ls,pic_ls]=DiceIndex(list.all,sst.all,N);
% [index_ns,p_ns,pic_ns]=DiceIndex(nback.all,sst.all,N);

result=zeros;
result(1,1)=index_cf;
result(1,2)=p_cf;
result(2,1)=index_lf;
result(2,2)=p_lf;
result(3,1)=index_cl;
result(3,2)=p_cl;
% % result(4,1)=index_cn;
% % result(4,2)=p_cn;
% % result(5,1)=index_cs;
% % result(5,2)=p_cs;
% result(6,1)=index_fn;
% result(6,2)=p_fn;
% result(7,1)=index_fs;
% result(7,2)=p_fs;
% result(8,1)=index_ln;
% result(8,2)=p_ln;
% result(9,1)=index_ls;
% result(9,2)=p_ls;
% result(10,1)=index_ns;
% result(10,2)=p_ns;
% 
% 
% 
