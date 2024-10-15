figure;
subplot(1,3,3);
all=[shamp_cf,shamp_cl,shamp_lf];
all_cell={};
all_cell(1:10000,1)={'Card Flanker'};
all_cell(10001:20000,1)={'Card List'};
all_cell(20001:30000,1)={'Flanker List'};
vs=violinplot(all,all_cell);
