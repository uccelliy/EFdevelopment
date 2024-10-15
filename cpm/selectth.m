function result =selectth(DataSet1,DataSet2,DataSet3,DataSet4,DataSet5,DataSet6)
prediction_filename = inputname(1);
brain_name=inputname(6);

result=zeros;
i=0;
for th = [0.01,0.05,0.001,0.005,0.0001,0.0005,0.00001,0.00005,0.000001,0.000005]
i=i+1;
thresh = th;
[prediction_behav,brain_condition]=coattend5(DataSet1,DataSet6);
behav2 =table2array(coattend5(DataSet2,DataSet6));
behav3 =table2array(coattend5(DataSet3,DataSet6));
behav4 =table2array(coattend5(DataSet4,DataSet6));
behav5 =table2array(coattend5(DataSet5,DataSet6));

all_mats  = table2array(brain_condition);
all_behav = table2array(prediction_behav);
K=10;
time = 20;




rep_behav_pred = {[]};

for t = 1:time
    [~,~,~,~,~,behav_pred,~,~]  = bgpredict_behavior5(behav2,behav3,behav4,behav5,all_mats,all_behav,K,thresh);
    rep_behav_pred{t} = behav_pred;
end

rep_beh_premat = mean(cell2mat(rep_behav_pred),2);
[repR, ~] = corr(rep_beh_premat,all_behav);
result(i,1)=th;
result(i,2)=repR;
end

save([prediction_filename '_' brain_name],"result");

end