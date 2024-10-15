clear;

y=shamp_lf_smri;
y=y';
violin(y,'xlabel',{'SMRI'},'facecolor',[.3 .3 .3],'mc',[],'medc',[]);
hold on
scatter(1, index_lf_dti, 100, 'blue', 'filled');
scatter(1, index_lf_fmri, 100, 'blue', 'filled');
scatter(1, index_lf_smri, 100, 'blue', 'filled');%画坐标[1 2]点
axis([0 2 -0.5 2.5]) ;%调整坐标轴显示范围
hold on
print(figure1,'./4yearsdice.jpg','-r1200','-djpeg');